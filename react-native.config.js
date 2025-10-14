module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './android',
        packageImportPath: 'import com.usercentrics.reactnative.RNUsercentricsPackage;',
        packageInstance: 'new RNUsercentricsPackage()',
        cmakeListsPath: './android/src/main/jni/CMakeLists.txt',
        libraryName: 'rn_usercentrics',
      },
      ios: {
        sourceDir: './ios',
      },
    },
  },
};
