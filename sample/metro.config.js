const path = require("path");
const { getDefaultConfig } = require("@react-native/metro-config");
const exclusionList = require("metro-config/src/defaults/exclusionList");

const config = getDefaultConfig(__dirname);

config.resolver.extraNodeModules = {
  ...config.resolver.extraNodeModules,
  "@usercentrics/react-native-sdk": path.resolve(__dirname, "../"),
};

// Watch the SDK folder
config.watchFolders = [
  ...config.watchFolders,
  path.resolve(__dirname, "../"),
];

// Ignore non-JS config files
config.resolver.blacklistRE = exclusionList([
  /.*\/node_modules\/@usercentrics\/react-native-sdk\/.*\.eslintrc\.js/,
  /.*\/node_modules\/@usercentrics\/react-native-sdk\/.*\.md/,
]);

module.exports = config;
