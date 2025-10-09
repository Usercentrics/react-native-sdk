#!/bin/bash

# Script to publish a local version of the Usercentrics React Native SDK
# Usage: ./scripts/publish-local.sh [version]
# Example: ./scripts/publish-local.sh 2.24.0-local

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if version parameter is provided
if [ -z "$1" ]; then
    print_error "Version parameter is required!"
    echo "Usage: $0 [version]"
    echo "Example: $0 2.24.0-local"
    exit 1
fi

NEW_VERSION="$1"
ORIGINAL_VERSION=""

print_info "Starting local SDK publishing process..."
print_info "Target version: $NEW_VERSION"

# Check if we're in the correct directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Make sure you're running this script from the SDK root directory."
    exit 1
fi

# Check if jq is installed for JSON manipulation
if ! command -v jq &> /dev/null; then
    print_error "jq is required but not installed. Please install jq first."
    print_info "Install with: brew install jq (macOS) or apt-get install jq (Ubuntu)"
    exit 1
fi

# Backup original version
ORIGINAL_VERSION=$(jq -r '.version' package.json)
print_info "Original version: $ORIGINAL_VERSION"

# Function to restore original version
restore_version() {
    print_info "Restoring original version: $ORIGINAL_VERSION"
    jq --arg version "$ORIGINAL_VERSION" '.version = $version' package.json > package.json.tmp && mv package.json.tmp package.json
}

# Set trap to restore version on script exit
trap restore_version EXIT

# Update version in package.json
print_info "Updating package.json version to: $NEW_VERSION"
jq --arg version "$NEW_VERSION" '.version = $version' package.json > package.json.tmp && mv package.json.tmp package.json

# Clean previous build
print_info "Cleaning previous build..."
rm -rf lib/

# Compile TypeScript
print_info "Compiling TypeScript..."
if ! npm run compile; then
    print_error "TypeScript compilation failed!"
    exit 1
fi

print_success "TypeScript compilation completed"

# Create npm package
print_info "Creating npm package..."
PACKAGE_FILE=$(npm pack 2>&1 | tail -1)

if [ -z "$PACKAGE_FILE" ]; then
    print_error "Failed to create npm package!"
    exit 1
fi

print_success "Package created: $PACKAGE_FILE"

# Get absolute path of the package (macOS compatible)
PACKAGE_PATH="$(pwd)/$PACKAGE_FILE"
print_info "Package path: $PACKAGE_PATH"

# Display installation instructions
echo ""
print_success "Local SDK package created successfully!"
echo ""
print_info "To install this local version in your React Native project:"
echo "  cd /path/to/your/react-native-project"
echo "  npm uninstall @usercentrics/react-native-sdk"
echo "  npm install $PACKAGE_PATH"
echo ""
print_info "Or use the absolute path:"
echo "  npm install $PACKAGE_PATH"
echo ""
print_warning "Remember: This is a local version for testing purposes only."
print_warning "Don't forget to test thoroughly before publishing to npm registry."
