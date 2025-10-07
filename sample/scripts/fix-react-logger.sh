#!/bin/bash

# Script to fix React-logger compatibility issues with Xcode 26
# This script should be executed after each 'pod install'

echo "🔧 Applying React-logger fixes for Xcode 26..."

# Path to React-logger-umbrella.h file
UMBRELLA_FILE="ios/Pods/Target Support Files/React-logger/React-logger-umbrella.h"

if [ -f "$UMBRELLA_FILE" ]; then
    echo "📝 Fixing includes in React-logger-umbrella.h..."
    
    # Fix include from double quotes to angle brackets
    sed -i '' 's|#import "react_native_log.h"|#import <React-logger/react_native_log.h>|g' "$UMBRELLA_FILE"
    
    echo "✅ React-logger-umbrella.h fixed!"
else
    echo "⚠️  React-logger-umbrella.h file not found. Run 'pod install' first."
fi

echo "🎉 React-logger fixes applied successfully!"
