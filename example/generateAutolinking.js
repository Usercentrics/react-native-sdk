const { spawnSync } = require("child_process");
const path = require("path");
const fs = require("fs");

console.log("🔄 Generating autolinking.json...");

const outputDir = path.resolve(__dirname, "android/build/generated/autolinking");
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

const result = spawnSync(
  "npx",
  ["react-native", "config"],
  { encoding: "utf-8" }
);

if (result.error) {
  console.error("❌ Error running react-native config", result.error);
  process.exit(1);
}

const config = JSON.parse(result.stdout);

if (!config.project?.android?.packageName) {
  console.error("❌ project.android.packageName not found in config!");
  process.exit(1);
}

fs.writeFileSync(
  path.join(outputDir, "autolinking.json"),
  JSON.stringify(config, null, 2)
);

console.log("✅ autolinking.json generated at:", outputDir);
