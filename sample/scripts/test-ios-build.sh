#!/bin/bash

# Script to test iOS compilation after React-logger fixes

echo "🧪 Testing iOS compilation with React-logger fixes..."

# Navigate to iOS directory
cd ios

# Clean previous build
echo "🧹 Cleaning previous build..."
xcodebuild clean -workspace sample.xcworkspace -scheme sample

# Clean CocoaPods cache to avoid build_configurations errors
echo "🧹 Cleaning CocoaPods cache..."
pod cache clean --all
rm -rf ~/Library/Caches/CocoaPods

# Reinstall pods with additional safety measures
echo "📦 Reinstalling pods with CI fixes..."
pod install --repo-update --verbose

# Find available iOS simulator
echo "🔍 Finding available iOS simulator..."
SIMULATOR=$(xcrun simctl list devices | grep "iPhone" | head -1 | grep -o '([A-F0-9-]*)' | tr -d '()')

if [ -z "$SIMULATOR" ]; then
    echo "❌ No iPhone simulator found. Please install iOS Simulator from Xcode."
    exit 1
fi

echo "📱 Using simulator: $SIMULATOR"

# Try to compile for simulator
echo "🔨 Compiling for iOS simulator..."
xcodebuild build \
  -workspace sample.xcworkspace \
  -scheme sample \
  -destination "platform=iOS Simulator,id=$SIMULATOR" \
  -configuration Debug \
  -quiet

if [ $? -eq 0 ]; then
    echo "✅ Compilation successful! React-logger fixes worked."
    echo "🎉 Project ready for development with Xcode 26 + React Native 0.79!"
else
    echo "❌ Compilation failed. Check the errors above."
    exit 1
fi
