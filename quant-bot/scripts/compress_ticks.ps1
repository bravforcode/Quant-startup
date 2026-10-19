[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $DataCsv,

    [Parameter(Mandatory = $true)]
    [string] $AuditCsv,

    [string] $OutputDirectory = (Join-Path (Get-Location).Path 'compressed_ticks')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Sha256([string] $Path) {
    (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-GzipPayloadSha256([string] $Path) {
    $fileStream = [System.IO.File]::OpenRead($Path)
    $hash = [System.Security.Cryptography.SHA256]::Create()
    try {
        $gzipStream = [System.IO.Compression.GZipStream]::new(
            $fileStream,
            [System.IO.Compression.CompressionMode]::Decompress
        )
        try {
            $buffer = [byte[]]::new(65536)
            while (($read = $gzipStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                [void]$hash.TransformBlock($buffer, 0, $read, $buffer, 0)
            }
            [void]$hash.TransformFinalBlock([byte[]]::new(0), 0, 0)
            ([System.BitConverter]::ToString($hash.Hash)).Replace('-', '').ToLowerInvariant()
        }
        finally {
            $gzipStream.Dispose()
        }
    }
    finally {
        $hash.Dispose()
        $fileStream.Dispose()
    }
}

function Compress-FileToGzip([string] $Source, [string] $Destination) {
    $inputStream = [System.IO.File]::OpenRead($Source)
    try {
        $outputStream = [System.IO.FileStream]::new(
            $Destination,
            [System.IO.FileMode]::CreateNew,
            [System.IO.FileAccess]::Write,
            [System.IO.FileShare]::None
        )
        try {
            $gzipStream = [System.IO.Compression.GZipStream]::new(
                $outputStream,
                [System.IO.Compression.CompressionLevel]::Optimal
            )
            try {
                $inputStream.CopyTo($gzipStream, 65536)
            }
            finally {
                $gzipStream.Dispose()
            }
        }
        catch {
            $outputStream.Dispose()
            throw
        }
    }
    finally {
        $inputStream.Dispose()
    }
}

$dataItem = Get-Item -LiteralPath $DataCsv
$auditItem = Get-Item -LiteralPath $AuditCsv
if ($dataItem.FullName -eq $auditItem.FullName) {
    throw 'DataCsv and AuditCsv must be different files.'
}
if ($dataItem.Extension -cne '.csv' -or $auditItem.Extension -cne '.csv') {
    throw 'Both source files must have the .csv extension.'
}

$auditRows = @(Import-Csv -LiteralPath $auditItem.FullName)
$finalRows = @($auditRows | Where-Object { $_.record_type -ceq 'FINAL' })
if ($finalRows.Count -ne 1) {
    throw "Expected exactly one FINAL audit row; found $($finalRows.Count)."
}
$final = $finalRows[0]
if ($final.status -cne 'API_COMPLETE_UNVERIFIED') {
    throw "Refusing compression: collector status is '$($final.status)'."
}
$runRows = @($auditRows | Where-Object { $_.record_type -ceq 'RUN' })
if ($runRows.Count -ne 1 -or $runRows[0].status -cne 'RUNNING' -or
    @($auditRows | Where-Object { $_.run_id -cne $final.run_id }).Count -ne 0) {
    throw 'Audit run identity/status is inconsistent.'
}
$metadataRows = @($auditRows | Where-Object { $_.record_type -ceq 'META' })
$brokerMetadata = [ordered]@{}
foreach ($metadataRow in $metadataRows) {
    $parts = $metadataRow.status -split '=', 2
    if ($parts.Count -ne 2 -or [string]::IsNullOrWhiteSpace($parts[0]) -or
        $brokerMetadata.Contains($parts[0])) {
        throw 'Broker metadata row is malformed or duplicated.'
    }
    $brokerMetadata[$parts[0]] = $parts[1]
}
$requiredMetadata = @(
    'ACCOUNT_SERVER', 'ACCOUNT_TRADE_MODE', 'ACCOUNT_CURRENCY', 'SYMBOL_NAME',
    'SYMBOL_CURRENCY_BASE', 'SYMBOL_CURRENCY_PROFIT', 'SYMBOL_CURRENCY_MARGIN',
    'SYMBOL_DIGITS', 'SYMBOL_VOLUME_MIN', 'SYMBOL_VOLUME_MAX', 'SYMBOL_VOLUME_STEP',
    'SYMBOL_TRADE_TICK_SIZE', 'SYMBOL_TRADE_TICK_VALUE', 'SYMBOL_TRADE_CONTRACT_SIZE'
)
foreach ($key in $requiredMetadata) {
    if (-not $brokerMetadata.Contains($key) -or
        [string]::IsNullOrWhiteSpace($brokerMetadata[$key]) -or
        $brokerMetadata[$key] -ceq 'UNAVAILABLE') {
        throw "Required broker metadata missing: $key"
    }
}
if ($brokerMetadata.ACCOUNT_SERVER -cne 'ICMarketsSC-Demo' -or
    $brokerMetadata.ACCOUNT_TRADE_MODE -cne 'DEMO' -or
    $brokerMetadata.SYMBOL_NAME -cne 'EURUSD') {
    throw 'Broker metadata does not match the authorized demo account/symbol.'
}
$culture = [System.Globalization.CultureInfo]::InvariantCulture
$numberStyle = [System.Globalization.NumberStyles]::Float
$minLot = [decimal]::Parse($brokerMetadata.SYMBOL_VOLUME_MIN, $numberStyle, $culture)
$maxLot = [decimal]::Parse($brokerMetadata.SYMBOL_VOLUME_MAX, $numberStyle, $culture)
$lotStep = [decimal]::Parse($brokerMetadata.SYMBOL_VOLUME_STEP, $numberStyle, $culture)
$tickSize = [decimal]::Parse($brokerMetadata.SYMBOL_TRADE_TICK_SIZE, $numberStyle, $culture)
$contractSize = [decimal]::Parse($brokerMetadata.SYMBOL_TRADE_CONTRACT_SIZE, $numberStyle, $culture)
if ($minLot -le 0 -or $maxLot -lt $minLot -or $lotStep -le 0 -or
    $tickSize -le 0 -or $contractSize -le 0) {
    throw 'Broker lot/tick/contract metadata is outside valid positive bounds.'
}
if ([long]$final.failed_chunks -ne 0 -or
    [long]$final.successful_chunks -ne [long]$final.expected_chunks) {
    throw 'Refusing compression: chunk counts do not reconcile.'
}
if ([long]$final.to_msc - [long]$final.from_msc + 1 -ne 604800000) {
    throw 'Refusing compression: requested range is not exactly seven days.'
}
if ([long]$final.requested_from_msc -ne [long]$final.from_msc -or
    [long]$final.requested_to_msc -ne [long]$final.to_msc -or
    [long]$runRows[0].from_msc -ne [long]$final.from_msc -or
    [long]$runRows[0].to_msc -ne [long]$final.to_msc) {
    throw 'RUN and FINAL requested windows do not match.'
}
$chunkRows = @($auditRows | Where-Object { $_.record_type -ceq 'CHUNK' })
if ($chunkRows.Count -ne [int]$final.expected_chunks) {
    throw "Expected $($final.expected_chunks) CHUNK rows; found $($chunkRows.Count)."
}
$cursor = [long]$final.from_msc
$sumChunkTicks = 0L
foreach ($chunk in $chunkRows) {
    $chunkFrom = [long]$chunk.from_msc
    $chunkTo = [long]$chunk.to_msc
    $expectedTo = [Math]::Min($chunkFrom + 3599999, [long]$final.to_msc)
    if ($chunk.status -cne 'API_OK' -or $chunkFrom -ne $cursor -or
        $chunkTo -ne $expectedTo -or $chunkTo -lt $chunkFrom) {
        throw 'Chunk audit has a gap, overlap, invalid range, or non-OK status.'
    }
    $sumChunkTicks += [long]$chunk.tick_count
    $cursor = $chunkTo + 1
}
if ($cursor -ne ([long]$final.to_msc + 1) -or
    $sumChunkTicks -ne [long]$final.tick_count) {
    throw 'Chunk time coverage or tick counts do not reconcile.'
}
if ($dataItem.BaseName -cne "GRAXIA_EURUSD_ticks_$($final.run_id)" -or
    $auditItem.BaseName -cne "GRAXIA_EURUSD_audit_$($final.run_id)") {
    throw 'Data/audit filename run IDs do not match the final audit row.'
}

# Collector rows contain only scalar fields; count lines using bounded memory.
$lineCount = 0L
$reader = [System.IO.StreamReader]::new($dataItem.FullName, [System.Text.Encoding]::UTF8, $true)
try {
    $header = $reader.ReadLine()
    if (($header -replace '"', '') -cne 'time_msc,bid,ask,last,volume,volume_real,flags') {
        throw 'Unexpected data CSV header.'
    }
    while ($null -ne $reader.ReadLine()) {
        $lineCount++
    }
}
finally {
    $reader.Dispose()
}
if ($lineCount -ne [long]$final.tick_count) {
    throw "Data row count $lineCount does not match audit tick_count $($final.tick_count)."
}

if (-not (Test-Path -LiteralPath $OutputDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
}
$runDirectory = Join-Path (Resolve-Path -LiteralPath $OutputDirectory).Path "GRAXIA_$($final.run_id)"
if (Test-Path -LiteralPath $runDirectory) {
    throw "Refusing overwrite: output directory already exists: $runDirectory"
}
New-Item -ItemType Directory -Path $runDirectory | Out-Null

$dataGzip = Join-Path $runDirectory ($dataItem.Name + '.gz')
$auditGzip = Join-Path $runDirectory ($auditItem.Name + '.gz')
$manifestPath = Join-Path $runDirectory 'manifest.json'
try {
    Compress-FileToGzip -Source $dataItem.FullName -Destination $dataGzip
    Compress-FileToGzip -Source $auditItem.FullName -Destination $auditGzip

    $dataSourceHash = Get-Sha256 $dataItem.FullName
    $auditSourceHash = Get-Sha256 $auditItem.FullName
    if ((Get-GzipPayloadSha256 $dataGzip) -cne $dataSourceHash -or
        (Get-GzipPayloadSha256 $auditGzip) -cne $auditSourceHash) {
        throw 'Compressed payload hash mismatch; raw sources remain untouched.'
    }

    $manifest = [ordered]@{
        schema_version = 1
        run_id = $final.run_id
        collector_status = $final.status
        completeness_note = 'API calls/chunks reconciled; broker history exhaustiveness is not proven.'
        symbol = 'EURUSD'
        requested_lookback_days = 7
        requested_from_msc = [long]$final.from_msc
        requested_to_msc = [long]$final.to_msc
        tick_rows = $lineCount
        broker_symbol_metadata = $brokerMetadata
        expected_chunks = [int]$final.expected_chunks
        successful_chunks = [int]$final.successful_chunks
        failed_chunks = [int]$final.failed_chunks
        source_data = [ordered]@{
            name = $dataItem.Name
            bytes = $dataItem.Length
            sha256 = $dataSourceHash
        }
        source_audit = [ordered]@{
            name = $auditItem.Name
            bytes = $auditItem.Length
            sha256 = $auditSourceHash
        }
        compressed_data = [ordered]@{
            name = [System.IO.Path]::GetFileName($dataGzip)
            bytes = (Get-Item -LiteralPath $dataGzip).Length
            sha256 = Get-Sha256 $dataGzip
        }
        compressed_audit = [ordered]@{
            name = [System.IO.Path]::GetFileName($auditGzip)
            bytes = (Get-Item -LiteralPath $auditGzip).Length
            sha256 = Get-Sha256 $auditGzip
        }
        raw_sources_preserved = $true
        generated_utc = [DateTime]::UtcNow.ToString('o')
    }
    $json = $manifest | ConvertTo-Json -Depth 6
    [System.IO.File]::WriteAllText(
        $manifestPath,
        $json + [Environment]::NewLine,
        [System.Text.UTF8Encoding]::new($false)
    )
}
catch {
    throw "Compression/manifest failed. Raw sources remain untouched; inspect partial output '$runDirectory'. $($_.Exception.Message)"
}

[pscustomobject]@{
    status = 'COMPRESSED_API_EVIDENCE_UNVERIFIED'
    run_id = $final.run_id
    tick_rows = $lineCount
    output_directory = $runDirectory
    manifest = $manifestPath
}
