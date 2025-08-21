#!/bin/bash
set -e

# Kill processes on ports 8081 and 7007
lsof -i tcp:8081 | awk 'NR!=1 {print $2}' | xargs kill 2>/dev/null || true
lsof -i tcp:7007 | awk 'NR!=1 {print $2}' | xargs kill 2>/dev/null || true

# Detect current directory and navigate to example folder if needed
if [[ "$(basename "$PWD")" == "react-native-sdk" ]]; then
    echo "📍 Running from project root, navigating to example folder..."
    cd example
elif [[ "$(basename "$PWD")" == "scripts" ]]; then
    echo "📍 Running from scripts folder, navigating to example folder..."
    cd ../example
elif [[ "$(basename "$PWD")" == "example" ]]; then
    echo "📍 Already in example folder"
else
    echo "❌ Unknown directory: $PWD"
    exit 1
fi

echo "🤖 Starting Android build with Metro bundler..."
react-native run-android
