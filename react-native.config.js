module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './android',
        packageImportPath: 'import com.usercentrics.reactnative.RNUsercentricsPackage;',
        packageInstance: 'new RNUsercentricsPackage()',
        componentDescriptors: []
      },
      ios: {
        sourceDir: './ios',
      },
    },
  },
};
