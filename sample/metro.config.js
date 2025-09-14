const path = require('path');
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

const customConfig = async () => {
  const {
    resolver: { sourceExts, assetExts },
  } = await getDefaultConfig(__dirname);

  const customSourceExts = [...sourceExts, 'svg', 'json', 'prod.ts', 'prod.tsx'];
  const newAssetExts = assetExts.filter(ext => ext !== 'svg');

  return {
    transformer: {
      getTransformOptions: async () => ({
        transform: {
          experimentalImportSupport: false,
          inlineRequires: true,
        },
      }),
    },
    resolver: {
      assetExts: newAssetExts,
      sourceExts: customSourceExts,
      extraNodeModules: {
        src: path.resolve(__dirname, 'src'),
      },
    },
    watchFolders: [
      path.resolve(__dirname, 'src'),
      path.resolve(__dirname, '..'),
    ],
  };
};

module.exports = (async () => {
  const defaultConfig = await getDefaultConfig(__dirname);
  const config = await customConfig();
  return mergeConfig(defaultConfig, config);
})();
