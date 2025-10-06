module.exports = {
  project: {
    android: {
      packageName: 'com.usercentrics.reactnativesdk.sample',
    },
  },
  dependencies: {
    '@usercentrics/react-native-sdk': {
      root: require('path').resolve(__dirname, '..'),
      platforms: {
        android: {
          sourceDir: require('path').resolve(__dirname, '../android'),
          packageImportPath: 'import com.usercentrics.reactnative.RNUsercentricsPackage;',
          packageInstance: 'new RNUsercentricsPackage()',
        },
        ios: {
          podspecPath: require('path').resolve(__dirname, '../react-native-usercentrics.podspec'),
        },
      },
    },
  },
};
