// Builds one self-contained HTML file for sharing, with engine.js and sample_data.js inlined.
// Run:  node startup-validation/mvp/robustness-check/build_standalone.js
const fs = require("node:fs");
const path = require("node:path");

const dir = __dirname;
const read = (name) => fs.readFileSync(path.join(dir, name), "utf8");

const engineTag = '<script src="engine.js"></script>';
const sampleTag = '<script src="sample_data.js"></script>';
const html = read("index.html");
if (!html.includes(engineTag) || !html.includes(sampleTag)) {
  throw new Error("index.html no longer references engine.js and sample_data.js as expected");
}

const out = html
  .replace(engineTag, () => `<script>\n${read("engine.js")}\n</script>`)
  .replace(sampleTag, () => `<script>\n${read("sample_data.js")}\n</script>`);

fs.mkdirSync(path.join(dir, "dist"), { recursive: true });
const target = path.join(dir, "dist", "robustness-check.html");
fs.writeFileSync(target, out);
console.log(`wrote ${path.relative(process.cwd(), target)} (${out.length} bytes)`);
