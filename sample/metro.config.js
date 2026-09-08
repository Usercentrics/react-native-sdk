const path = require("path");
const { getDefaultConfig } = require("@react-native/metro-config");

const config = getDefaultConfig(__dirname);

config.resolver.extraNodeModules = {
  ...config.resolver.extraNodeModules,
  "@usercentrics/react-native-sdk": path.resolve(__dirname, "../"),
};

// Force a single react-native copy — the SDK's own node_modules/react-native (0.79.7) is a
// separate install from the sample's (0.81.4), which was creating two disconnected
// RCTDeviceEventEmitter singletons: native events emitted through the SDK's copy never
// reached listeners registered through the sample app's copy. extraNodeModules alone doesn't
// work here since it's only a fallback consulted when normal resolution fails — react-native
// resolves fine in both locations, so we need to intercept resolution directly.
const sampleReactNative = path.resolve(__dirname, "node_modules/react-native");
config.resolver.resolveRequest = (context, moduleName, platform) => {
  if (moduleName === "react-native" || moduleName.startsWith("react-native/")) {
    return context.resolveRequest(
      context,
      path.join(sampleReactNative, moduleName.slice("react-native".length)),
      platform
    );
  }
  return context.resolveRequest(context, moduleName, platform);
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
