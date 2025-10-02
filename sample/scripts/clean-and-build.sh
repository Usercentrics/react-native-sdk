#!/bin/bash

set -e

echo "🧹 Simplified cleanup and build script..."

# ------------------------------
# CACHE CLEANUP
# ------------------------------
echo "📂 Cleaning DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

echo "🏗️ Cleaning old iOS project builds..."
cd ios
rm -rf build
xcodebuild clean || echo "⚠️  xcodebuild clean failed, continuing..."
rm -rf Pods
cd ..

echo "🥣 Cleaning CocoaPods cache..."
pod cache clean --all
rm -rf ~/Library/Caches/CocoaPods

echo "🧶 Cleaning Yarn cache..."
yarn cache clean

echo "🚀 Cleaning Metro bundler cache..."
rm -rf /tmp/metro-*

# ------------------------------
# PODS INSTALLATION
# ------------------------------
echo "📦 Installing pods..."
cd ios
pod install --repo-update
cd ..

# ------------------------------
# XCFRAMEWORKS VERIFICATION
# ------------------------------
echo "🔍 Checking available XCFrameworks..."
XCFRAMEWORKS=("UsercentricsUI")
for XCFRAMEWORK in "${XCFRAMEWORKS[@]}"; do
  XCFRAMEWORK_PATH="ios/Pods/$XCFRAMEWORK/$XCFRAMEWORK.xcframework"
  if [ -d "$XCFRAMEWORK_PATH" ]; then
    echo "✅ $XCFRAMEWORK XCFramework found at: $XCFRAMEWORK_PATH"
  else
    echo "⚠️  $XCFRAMEWORK XCFramework not found at: $XCFRAMEWORK_PATH"
  fi
done

# ------------------------------
# FINAL APP BUILD
# ------------------------------
echo ""
echo "📦 Building final app..."
echo "=========================================="

cd ios
xcodebuild -workspace sample.xcworkspace \
  -scheme sample \
  -configuration Debug \
  -sdk iphonesimulator \
  BUILD_DIR=build clean build

echo ""
echo "🎉 Final app build completed successfully!"
echo "✅ The app has been built and is ready for use in the simulator"
