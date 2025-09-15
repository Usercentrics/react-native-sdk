const path = require("path");
const { getDefaultConfig } = require("@react-native/metro-config");

const config = getDefaultConfig(__dirname);

config.resolver.extraNodeModules = {
  ...config.resolver.extraNodeModules,
  "@usercentrics/react-native-sdk": path.resolve(__dirname, "../"),
};

config.watchFolders = [
  ...config.watchFolders,
  path.resolve(__dirname, "../"),
];

module.exports = config;