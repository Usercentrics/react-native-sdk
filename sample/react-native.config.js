module.exports = {
  project: {
    android: {
      packageName: 'com.usercentrics.reactnativesdk.sample',
    },
  },
  dependencies: {
    'react-native-usercentrics': {
      platforms: {
        android: null, // disable Android platform auto linking
        ios: {
          podspecPath: require('path').resolve(__dirname, '../react-native-usercentrics.podspec'),
        },
      },
    },
  },
};
