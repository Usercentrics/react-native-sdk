const path = require("path");
const { getDefaultConfig } = require("@react-native/metro-config");

const config = getDefaultConfig(__dirname);

config.resolver.extraNodeModules = {
  ...config.resolver.extraNodeModules,
  "@usercentrics/react-native-sdk": path.resolve(__dirname, "../"),
};

// Tell Metro where to resolve modules from — needed so that files inside
// the SDK's node_modules can resolve their own transitive dependencies.
config.resolver.nodeModulesPaths = [
  path.resolve(__dirname, "node_modules"),
  path.resolve(__dirname, "../node_modules"),
];

// Watch the SDK folder
config.watchFolders = [
  ...config.watchFolders,
  path.resolve(__dirname, "../"),
];

module.exports = config;
