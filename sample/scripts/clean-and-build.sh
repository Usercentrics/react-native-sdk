#!/bin/bash
# Script for complete cleanup and build of sample Android

echo "🧹 Starting complete cleanup and build of sample Android..."

# Navigate to sample directory if not already in it
if [[ "$(basename "$PWD")" != "sample" ]]; then
    echo "📍 Navigating to sample directory..."
    cd sample
fi

echo "📱 Cleaning Android project..."
cd android
./gradlew clean
rm -rf app/.cxx
rm -rf ../node_modules/react-native-screens/android/.cxx
rm -rf ../node_modules/react-native-screens/android/build
cd ..

echo "🔨 Building APK..."
cd android
./gradlew assembleDebug

echo "✅ Cleanup and build completed!"
echo "📱 APK generated at: android/app/build/outputs/apk/debug/app-debug.apk"
