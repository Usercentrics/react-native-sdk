module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './android',
        packageImportPath: 'import com.usercentrics.reactnative.RNUsercentricsPackage;',
        packageInstance: 'new RNUsercentricsPackage()',
      },
      ios: {
        podspecPath: './react-native-usercentrics.podspec',
      },
    },
  },
};
