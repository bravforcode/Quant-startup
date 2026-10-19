[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$tempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\') + '\'
$testRoot = Join-Path $tempBase ("graxia-tick-test-" + [guid]::NewGuid().ToString('N'))
$testRootFull = [System.IO.Path]::GetFullPath($testRoot)
$compressor = Join-Path (Split-Path -Parent $PSScriptRoot) 'scripts/compress_ticks.ps1'

function New-AuditRow(
    [string] $RecordType,
    [string] $RunId,
    [long] $From,
    [long] $To,
    [long] $TickCount,
    [int] $Attempt,
    [int] $ErrorCode,
    [string] $Status,
    [int] $Expected,
    [int] $Successful,
    [int] $Failed,
    [long] $WindowFrom,
    [long] $WindowTo
) {
    [pscustomobject][ordered]@{
        record_type = $RecordType
        run_id = $RunId
        from_msc = $From
        to_msc = $To
        tick_count = $TickCount
        attempt = $Attempt
        error_code = $ErrorCode
        status = $Status
        expected_chunks = $Expected
        successful_chunks = $Successful
        failed_chunks = $Failed
        requested_from_msc = $WindowFrom
        requested_to_msc = $WindowTo
    }
}

function Write-Fixture([string] $Directory, [string] $RunId, [string] $FinalStatus) {
    $start = 1700000000000L
    $end = $start + 604800000L - 1
    $dataPath = Join-Path $Directory "GRAXIA_EURUSD_ticks_$RunId.csv"
    $auditPath = Join-Path $Directory "GRAXIA_EURUSD_audit_$RunId.csv"

    @(
        [pscustomobject][ordered]@{ time_msc = $start + 1000; bid = '1.10000'; ask = '1.10010'; last = '0.00000'; volume = 0; volume_real = '0.0000000000000000'; flags = 6 }
        [pscustomobject][ordered]@{ time_msc = $start + 3601000; bid = '1.10001'; ask = '1.10011'; last = '0.00000'; volume = 0; volume_real = '0.0000000000000000'; flags = 6 }
    ) | Export-Csv -LiteralPath $dataPath -NoTypeInformation -Encoding UTF8

    $rows = [System.Collections.Generic.List[object]]::new()
    $rows.Add((New-AuditRow 'RUN' $RunId $start $end 0 0 0 'RUNNING' 168 0 0 $start $end))
    $metadata = [ordered]@{
        ACCOUNT_SERVER = 'ICMarketsSC-Demo'
        ACCOUNT_TRADE_MODE = 'DEMO'
        ACCOUNT_CURRENCY = 'USD'
        SYMBOL_NAME = 'EURUSD'
        SYMBOL_CURRENCY_BASE = 'EUR'
        SYMBOL_CURRENCY_PROFIT = 'USD'
        SYMBOL_CURRENCY_MARGIN = 'EUR'
        SYMBOL_DIGITS = '5'
        SYMBOL_VOLUME_MIN = '0.01'
        SYMBOL_VOLUME_MAX = '100'
        SYMBOL_VOLUME_STEP = '0.01'
        SYMBOL_TRADE_TICK_SIZE = '0.00001'
        SYMBOL_TRADE_TICK_VALUE = '1'
        SYMBOL_TRADE_CONTRACT_SIZE = '100000'
    }
    foreach ($key in $metadata.Keys) {
        $rows.Add((New-AuditRow 'META' $RunId 0 0 0 0 0 "$key=$($metadata[$key])" 168 0 0 $start $end))
    }
    for ($i = 0; $i -lt 168; $i++) {
        $chunkFrom = $start + ([long]$i * 3600000L)
        $chunkTo = $chunkFrom + 3599999L
        $ticks = if ($i -lt 2) { 1L } else { 0L }
        $rows.Add((New-AuditRow 'CHUNK' $RunId $chunkFrom $chunkTo $ticks 1 0 'API_OK' 168 ($i + 1) 0 $start $end))
    }
    $rows.Add((New-AuditRow 'FINAL' $RunId $start $end 2 0 0 $FinalStatus 168 168 0 $start $end))
    $rows | Export-Csv -LiteralPath $auditPath -NoTypeInformation -Encoding UTF8
    [pscustomobject]@{ Data = $dataPath; Audit = $auditPath }
}

New-Item -ItemType Directory -Path $testRootFull | Out-Null
try {
    $good = Write-Fixture -Directory $testRootFull -RunId '1700000000000_100' -FinalStatus 'API_COMPLETE_UNVERIFIED'
    $goodOutput = Join-Path $testRootFull 'good-output'
    $result = & $compressor -DataCsv $good.Data -AuditCsv $good.Audit -OutputDirectory $goodOutput
    if ($result.status -cne 'COMPRESSED_API_EVIDENCE_UNVERIFIED') {
        throw "Unexpected positive-test status: $($result.status)"
    }
    if (-not (Test-Path -LiteralPath $good.Data) -or -not (Test-Path -LiteralPath $good.Audit)) {
        throw 'Raw source fixture was removed.'
    }
    $manifest = Get-Content -LiteralPath $result.manifest -Raw | ConvertFrom-Json
    if ($manifest.tick_rows -ne 2 -or
        $manifest.completeness_note -notmatch 'not proven' -or
        $manifest.broker_symbol_metadata.SYMBOL_VOLUME_MIN -cne '0.01') {
        throw 'Manifest count or uncertainty statement is missing.'
    }

    $bad = Write-Fixture -Directory $testRootFull -RunId '1700000000000_200' -FinalStatus 'INCOMPLETE'
    $badOutput = Join-Path $testRootFull 'bad-output'
    $refused = $false
    try {
        & $compressor -DataCsv $bad.Data -AuditCsv $bad.Audit -OutputDirectory $badOutput | Out-Null
    }
    catch {
        $refused = $true
    }
    if (-not $refused -or (Test-Path -LiteralPath $badOutput)) {
        throw 'Negative gate failed: incomplete run was not refused before output creation.'
    }

    $wrongServer = Write-Fixture -Directory $testRootFull -RunId '1700000000000_300' -FinalStatus 'API_COMPLETE_UNVERIFIED'
    $wrongRows = @(Import-Csv -LiteralPath $wrongServer.Audit)
    $serverRow = $wrongRows | Where-Object {
        $_.record_type -ceq 'META' -and $_.status -like 'ACCOUNT_SERVER=*'
    }
    if ($null -eq $serverRow) {
        throw 'Wrong-server fixture is missing its server metadata row.'
    }
    $serverRow.status = 'ACCOUNT_SERVER=Pepperstone-Demo'
    $wrongRows | Export-Csv -LiteralPath $wrongServer.Audit -NoTypeInformation -Encoding UTF8 -Force
    $wrongOutput = Join-Path $testRootFull 'wrong-server-output'
    $refused = $false
    try {
        & $compressor -DataCsv $wrongServer.Data -AuditCsv $wrongServer.Audit -OutputDirectory $wrongOutput | Out-Null
    }
    catch {
        $refused = $true
    }
    if (-not $refused -or (Test-Path -LiteralPath $wrongOutput)) {
        throw 'Negative gate failed: wrong-server evidence was not refused before output creation.'
    }

    'PASS: complete-but-unverified evidence compressed and manifested; raw inputs preserved.'
    'PASS: incomplete campaign refused before output creation.'
    'PASS: wrong-server evidence refused before output creation.'
}
finally {
    $safePrefix = $tempBase + 'graxia-tick-test-'
    if ($testRootFull.StartsWith($safePrefix, [System.StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path -Leaf $testRootFull).StartsWith('graxia-tick-test-', [System.StringComparison]::OrdinalIgnoreCase)) {
        Remove-Item -LiteralPath $testRootFull -Recurse -Force
    }
}
