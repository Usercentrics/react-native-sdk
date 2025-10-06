#!/bin/bash

# Script to fix Xcode sandbox and module validation issues after pod install
# NOTE: These settings are now configured in Podfile post_install hook
# This script is kept as a backup/fallback solution

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
IOS_DIR="$PROJECT_ROOT/ios"
PODS_PROJECT="$IOS_DIR/Pods/Pods.xcodeproj/project.pbxproj"

echo "🔧 Fixing Xcode Build Settings..."

# Check if Pods project exists
if [ ! -f "$PODS_PROJECT" ]; then
    echo "❌ Error: Pods project not found at $PODS_PROJECT"
    echo "Please run 'pod install' first"
    exit 1
fi

# Backup the original file
cp "$PODS_PROJECT" "$PODS_PROJECT.backup"
echo "✅ Backup created: $PODS_PROJECT.backup"

# 1. Disable ENABLE_USER_SCRIPT_SANDBOXING
echo "🔧 Disabling user script sandboxing..."
sed -i '' 's/ENABLE_USER_SCRIPT_SANDBOXING = YES;/ENABLE_USER_SCRIPT_SANDBOXING = NO;/g' "$PODS_PROJECT"
sed -i '' 's/ENABLE_USER_SCRIPT_SANDBOXING = YES/ENABLE_USER_SCRIPT_SANDBOXING = NO/g' "$PODS_PROJECT"

SANDBOX_CHANGES=$(grep -c "ENABLE_USER_SCRIPT_SANDBOXING = NO" "$PODS_PROJECT" || true)
echo "✅ Disabled sandbox in $SANDBOX_CHANGES locations"

# 2. Disable VALIDATE_MODULES for all targets
echo "🔧 Disabling module validation..."
sed -i '' 's/VALIDATE_MODULES = YES;/VALIDATE_MODULES = NO;/g' "$PODS_PROJECT"
sed -i '' 's/VALIDATE_MODULES = YES/VALIDATE_MODULES = NO/g' "$PODS_PROJECT"

# Also add VALIDATE_MODULES = NO where it doesn't exist
# This ensures all build configurations have it disabled
perl -i -pe 's/(buildSettings = \{)/${1}\n\t\t\t\tVALIDATE_MODULES = NO;/g unless /VALIDATE_MODULES/' "$PODS_PROJECT"

MODULE_CHANGES=$(grep -c "VALIDATE_MODULES = NO" "$PODS_PROJECT" || true)
echo "✅ Disabled module validation in $MODULE_CHANGES locations"

echo ""
echo "✨ All done! You can now build the iOS project"
echo ""
echo "⚠️  Remember: You need to run this script after every 'pod install'"

