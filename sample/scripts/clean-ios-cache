#!/bin/bash

echo "🧹 Cleaning Xcode and React Native caches..."

# 1️⃣ Clean DerivedData
echo "📂 Cleaning DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# 2️⃣ Clean iOS project build
echo "🏗️ Cleaning iOS project build folders..."
cd ios
# Manually remove build folder first
rm -rf build
# Try to clean with xcodebuild, but don't fail if it errors
xcodebuild clean || echo "⚠️  xcodebuild clean failed, continuing..."
cd ..

# 3️⃣ Clean Cocoapods cache
echo "🥣 Cleaning Cocoapods cache..."
if [ -f "ios/Podfile" ]; then
  cd ios
  pod cache clean --all
  rm -rf Pods
  rm -rf ~/Library/Caches/CocoaPods
  pod install --repo-update
  cd ..
else
  echo "⚠️  Podfile not found, skipping Cocoapods cleanup"
fi

# 4️⃣ Clean Yarn cache
echo "🧶 Cleaning Yarn cache..."
yarn cache clean

# 5️⃣ Clean Metro bundler cache
echo "🚀 Cleaning Metro bundler cache..."
rm -rf /tmp/metro-*

echo "✅ All caches have been cleaned. Now try rebuilding the project!"
