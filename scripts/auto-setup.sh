#!/bin/bash
# Automated setup script for Usercentrics React Native SDK
# This script will install and configure all necessary dependencies

set -e  # Exit on any error

echo "🚀 USERCENTRICS REACT NATIVE SDK - AUTOMATED SETUP"
echo "=================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Status counters
INSTALLED=0
SKIPPED=0
FAILED=0

# Function to print status
print_status() {
    local status=$1
    local message=$2
    local details=$3
    
    if [ "$status" = "SUCCESS" ]; then
        echo -e "✅ ${GREEN}INSTALLED${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${BLUE}ℹ️  $details${NC}"
        ((INSTALLED++))
    elif [ "$status" = "SKIP" ]; then
        echo -e "⏭️  ${YELLOW}SKIPPED${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${YELLOW}💡 $details${NC}"
        ((SKIPPED++))
    elif [ "$status" = "FAIL" ]; then
        echo -e "❌ ${RED}FAILED${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${RED}⚠️  $details${NC}"
        ((FAILED++))
    elif [ "$status" = "INFO" ]; then
        echo -e "ℹ️  ${BLUE}INFO${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${BLUE}💡 $details${NC}"
    fi
    echo ""
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check version compatibility
check_version() {
    local current=$1
    local required=$2
    
    if [ -z "$current" ]; then
        return 1
    fi
    
    # Simple version comparison for major.minor
    current_major=$(echo $current | cut -d. -f1)
    current_minor=$(echo $current | cut -d. -f2)
    required_major=$(echo $required | cut -d. -f1)
    required_minor=$(echo $required | cut -d. -f2)
    
    if [ "$current_major" -gt "$required_major" ] || 
       ([ "$current_major" -eq "$required_major" ] && [ "$current_minor" -ge "$required_minor" ]); then
        return 0
    else
        return 1
    fi
}

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
fi

# Detect project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

print_status "INFO" "Detected OS: $OS"
print_status "INFO" "Project Root: $PROJECT_ROOT"

# ============================================================================
echo "📦 PACKAGE MANAGERS"
echo "============================================================================"

# Install Homebrew (macOS only)
if [ "$OS" = "macos" ]; then
    if command_exists brew; then
        print_status "SKIP" "Homebrew already installed" "$(brew --version | head -1)"
    else
        print_status "INFO" "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
        print_status "SUCCESS" "Homebrew installed" || \
        print_status "FAIL" "Failed to install Homebrew"
    fi
fi

# ============================================================================
echo "🔧 DEVELOPMENT ENVIRONMENT"
echo "============================================================================"

# Install Node.js (if not present or too old)
if command_exists node; then
    NODE_VERSION=$(node --version | sed 's/v//')
    if check_version "$NODE_VERSION" "18.0"; then
        print_status "SKIP" "Node.js $NODE_VERSION already installed" "Required: >= 18.0"
    else
        print_status "INFO" "Updating Node.js from $NODE_VERSION to >= 18.0..."
        if [ "$OS" = "macos" ]; then
            brew install node@18 && \
            print_status "SUCCESS" "Node.js updated" || \
            print_status "FAIL" "Failed to update Node.js"
        else
            print_status "INFO" "Please update Node.js manually to >= 18.0"
        fi
    fi
else
    print_status "INFO" "Installing Node.js..."
    if [ "$OS" = "macos" ]; then
        brew install node@18 && \
        print_status "SUCCESS" "Node.js installed" || \
        print_status "FAIL" "Failed to install Node.js"
    else
        print_status "INFO" "Please install Node.js >= 18.0 manually"
    fi
fi

# Install TypeScript globally
if command_exists tsc; then
    TS_VERSION=$(tsc --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    if check_version "$TS_VERSION" "5.1"; then
        print_status "SKIP" "TypeScript $TS_VERSION already installed" "Required: >= 5.1"
    else
        print_status "INFO" "Updating TypeScript globally..."
        npm install -g typescript@latest && \
        print_status "SUCCESS" "TypeScript updated globally" || \
        print_status "FAIL" "Failed to update TypeScript"
    fi
else
    print_status "INFO" "Installing TypeScript globally..."
    npm install -g typescript@latest && \
    print_status "SUCCESS" "TypeScript installed globally" || \
    print_status "FAIL" "Failed to install TypeScript"
fi

# Install React Native CLI
if command_exists npx && npx react-native --version >/dev/null 2>&1; then
    print_status "SKIP" "React Native CLI available" "Using npx"
else
    print_status "INFO" "Installing React Native CLI..."
    npm install -g @react-native-community/cli && \
    print_status "SUCCESS" "React Native CLI installed" || \
    print_status "FAIL" "Failed to install React Native CLI"
fi

# ============================================================================
echo "☕ JAVA ENVIRONMENT"
echo "============================================================================"

# Install Java (using SDKMan if available, otherwise system package manager)
if command_exists java; then
    JAVA_VERSION=$(java -version 2>&1 | head -n1 | grep -o '[0-9]\+' | head -1)
    if [ "$JAVA_VERSION" -ge 17 ]; then
        print_status "SKIP" "Java $JAVA_VERSION already installed" "Required: >= 17"
    else
        print_status "INFO" "Java version $JAVA_VERSION is too old, updating..."
        if command_exists sdk; then
            sdk install java 17.0.2-zulu && \
            print_status "SUCCESS" "Java 17 installed via SDKMan" || \
            print_status "FAIL" "Failed to install Java via SDKMan"
        elif [ "$OS" = "macos" ]; then
            brew install openjdk@17 && \
            print_status "SUCCESS" "Java 17 installed via Homebrew" || \
            print_status "FAIL" "Failed to install Java via Homebrew"
        else
            print_status "INFO" "Please install Java 17+ manually"
        fi
    fi
else
    print_status "INFO" "Installing Java 17..."
    if command_exists sdk; then
        sdk install java 17.0.2-zulu && \
        print_status "SUCCESS" "Java 17 installed via SDKMan" || \
        print_status "FAIL" "Failed to install Java via SDKMan"
    elif [ "$OS" = "macos" ]; then
        brew install openjdk@17 && \
        print_status "SUCCESS" "Java 17 installed via Homebrew" || \
        print_status "FAIL" "Failed to install Java via Homebrew"
    else
        print_status "INFO" "Please install Java 17+ manually"
    fi
fi

# Set JAVA_HOME if not set
if [ -z "$JAVA_HOME" ]; then
    if [ "$OS" = "macos" ] && [ -d "/usr/local/opt/openjdk@17" ]; then
        export JAVA_HOME="/usr/local/opt/openjdk@17"
        echo 'export JAVA_HOME="/usr/local/opt/openjdk@17"' >> ~/.zshrc
        print_status "SUCCESS" "JAVA_HOME set to $JAVA_HOME"
    elif command_exists sdk; then
        JAVA_HOME_CANDIDATE=$(sdk home java 17.0.2-zulu 2>/dev/null || echo "")
        if [ ! -z "$JAVA_HOME_CANDIDATE" ]; then
            export JAVA_HOME="$JAVA_HOME_CANDIDATE"
            echo "export JAVA_HOME=\"$JAVA_HOME_CANDIDATE\"" >> ~/.zshrc
            print_status "SUCCESS" "JAVA_HOME set to $JAVA_HOME"
        fi
    else
        print_status "INFO" "Please set JAVA_HOME manually"
    fi
else
    print_status "SKIP" "JAVA_HOME already set" "$JAVA_HOME"
fi

# ============================================================================
echo "🤖 ANDROID ENVIRONMENT"
echo "============================================================================"

# Install Android SDK (if not present)
if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
    print_status "INFO" "Installing Android SDK..."
    if [ "$OS" = "macos" ]; then
        brew install android-sdk && \
        export ANDROID_HOME="/usr/local/share/android-sdk" && \
        echo 'export ANDROID_HOME="/usr/local/share/android-sdk"' >> ~/.zshrc && \
        echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools' >> ~/.zshrc && \
        print_status "SUCCESS" "Android SDK installed" || \
        print_status "FAIL" "Failed to install Android SDK"
    else
        print_status "INFO" "Please install Android SDK manually and set ANDROID_HOME"
    fi
else
    SDK_ROOT=${ANDROID_HOME:-$ANDROID_SDK_ROOT}
    print_status "SKIP" "Android SDK already configured" "$SDK_ROOT"
fi

# Install Android Studio command line tools (if SDK exists)
if [ ! -z "$ANDROID_HOME" ] || [ ! -z "$ANDROID_SDK_ROOT" ]; then
    SDK_ROOT=${ANDROID_HOME:-$ANDROID_SDK_ROOT}
    
    # Install required SDK components
    if [ -f "$SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" ]; then
        print_status "INFO" "Installing Android SDK components..."
        
        # Accept licenses
        yes | $SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses >/dev/null 2>&1
        
        # Install required components
        $SDK_ROOT/cmdline-tools/latest/bin/sdkmanager \
            "platform-tools" \
            "platforms;android-33" \
            "platforms;android-34" \
            "build-tools;33.0.0" \
            "build-tools;34.0.0" \
            "cmake;3.22.1" \
            "ndk;25.1.8937393" >/dev/null 2>&1 && \
        print_status "SUCCESS" "Android SDK components installed" || \
        print_status "FAIL" "Failed to install Android SDK components"
    else
        print_status "INFO" "Please install Android SDK command line tools manually"
    fi
fi

# Install Gradle
if command_exists gradle; then
    GRADLE_VERSION=$(gradle --version | grep "Gradle" | grep -o '[0-9]\+\.[0-9]\+')
    if check_version "$GRADLE_VERSION" "8.2"; then
        print_status "SKIP" "Gradle $GRADLE_VERSION already installed" "Required: >= 8.2"
    else
        print_status "INFO" "Updating Gradle..."
        if [ "$OS" = "macos" ]; then
            brew upgrade gradle && \
            print_status "SUCCESS" "Gradle updated" || \
            print_status "FAIL" "Failed to update Gradle"
        fi
    fi
else
    print_status "INFO" "Installing Gradle..."
    if [ "$OS" = "macos" ]; then
        brew install gradle && \
        print_status "SUCCESS" "Gradle installed" || \
        print_status "FAIL" "Failed to install Gradle"
    else
        print_status "INFO" "Please install Gradle >= 8.2 manually"
    fi
fi

# ============================================================================
echo "🍎 iOS ENVIRONMENT (macOS only)"
echo "============================================================================"

if [ "$OS" = "macos" ]; then
    # Check Xcode
    if command_exists xcodebuild; then
        XCODE_VERSION=$(xcodebuild -version | head -1 | grep -o '[0-9]\+\.[0-9]\+')
        if check_version "$XCODE_VERSION" "15.0"; then
            print_status "SKIP" "Xcode $XCODE_VERSION already installed" "Required: >= 15.0"
        else
            print_status "INFO" "Please update Xcode to >= 15.0 from App Store"
        fi
    else
        print_status "INFO" "Please install Xcode from App Store"
    fi
    
    # Install CocoaPods
    if command_exists pod; then
        POD_VERSION=$(pod --version)
        if check_version "$POD_VERSION" "1.12"; then
            print_status "SKIP" "CocoaPods $POD_VERSION already installed" "Required: >= 1.12"
        else
            print_status "INFO" "Updating CocoaPods..."
            sudo gem install cocoapods && \
            print_status "SUCCESS" "CocoaPods updated" || \
            print_status "FAIL" "Failed to update CocoaPods"
        fi
    else
        print_status "INFO" "Installing CocoaPods..."
        sudo gem install cocoapods && \
        print_status "SUCCESS" "CocoaPods installed" || \
        print_status "FAIL" "Failed to install CocoaPods"
    fi
    
    # Install iOS Simulator (if Xcode is installed)
    if command_exists xcrun; then
        SIMULATORS=$(xcrun simctl list devices available 2>/dev/null | grep "iPhone" | wc -l)
        if [ "$SIMULATORS" -gt 0 ]; then
            print_status "SKIP" "iOS Simulators available" "$SIMULATORS simulators found"
        else
            print_status "INFO" "Please install iOS Simulators in Xcode"
        fi
    fi
else
    print_status "SKIP" "iOS development not available" "macOS required"
fi

# ============================================================================
echo "🔧 DEVELOPMENT TOOLS"
echo "============================================================================"

# Install Watchman
if command_exists watchman; then
    print_status "SKIP" "Watchman already installed" "$(watchman --version | head -1)"
else
    print_status "INFO" "Installing Watchman..."
    if [ "$OS" = "macos" ]; then
        brew install watchman && \
        print_status "SUCCESS" "Watchman installed" || \
        print_status "FAIL" "Failed to install Watchman"
    else
        print_status "INFO" "Please install Watchman manually"
    fi
fi

# Install Git (if not present)
if command_exists git; then
    print_status "SKIP" "Git already installed" "$(git --version)"
else
    print_status "INFO" "Installing Git..."
    if [ "$OS" = "macos" ]; then
        brew install git && \
        print_status "SUCCESS" "Git installed" || \
        print_status "FAIL" "Failed to install Git"
    else
        print_status "INFO" "Please install Git manually"
    fi
fi

# ============================================================================
echo "📦 PROJECT DEPENDENCIES"
echo "============================================================================"

# Install root dependencies
print_status "INFO" "Installing root project dependencies..."
cd "$PROJECT_ROOT"
npm install --legacy-peer-deps && \
print_status "SUCCESS" "Root dependencies installed" || \
print_status "FAIL" "Failed to install root dependencies"

# Install example dependencies
print_status "INFO" "Installing example project dependencies..."
cd "$PROJECT_ROOT/example"
npm install --legacy-peer-deps && \
print_status "SUCCESS" "Example dependencies installed" || \
print_status "FAIL" "Failed to install example dependencies"

# Apply patches
if [ -f "$PROJECT_ROOT/example/package.json" ] && grep -q "patch-package" "$PROJECT_ROOT/example/package.json"; then
    print_status "INFO" "Applying patches..."
    cd "$PROJECT_ROOT/example"
    npm run postinstall && \
    print_status "SUCCESS" "Patches applied" || \
    print_status "FAIL" "Failed to apply patches"
fi

# Compile TypeScript
print_status "INFO" "Compiling TypeScript..."
cd "$PROJECT_ROOT"
npm run compile && \
print_status "SUCCESS" "TypeScript compiled" || \
print_status "FAIL" "Failed to compile TypeScript"

# ============================================================================
echo "🧹 CLEANUP AND OPTIMIZATION"
echo "============================================================================"

# Clean all caches
print_status "INFO" "Cleaning all caches..."
cd "$PROJECT_ROOT"
if [ -f "scripts/clean-all-caches.sh" ]; then
    ./scripts/clean-all-caches.sh >/dev/null 2>&1 && \
    print_status "SUCCESS" "Caches cleaned" || \
    print_status "FAIL" "Failed to clean caches"
fi

# Reinstall dependencies after cleanup
print_status "INFO" "Reinstalling dependencies after cleanup..."
if [ -f "scripts/install-dependencies.sh" ]; then
    ./scripts/install-dependencies.sh >/dev/null 2>&1 && \
    print_status "SUCCESS" "Dependencies reinstalled" || \
    print_status "FAIL" "Failed to reinstall dependencies"
fi

# ============================================================================
echo "✅ VERIFICATION"
echo "============================================================================"

# Run requirements check
print_status "INFO" "Running requirements verification..."
if [ -f "$PROJECT_ROOT/scripts/check-requirements.sh" ]; then
    cd "$PROJECT_ROOT/example"
    if ../scripts/check-requirements.sh >/dev/null 2>&1; then
        print_status "SUCCESS" "All requirements verified" "Environment ready!"
    else
        print_status "INFO" "Some requirements still need attention" "Check the detailed report"
    fi
fi

# ============================================================================
echo "📊 SETUP SUMMARY"
echo "============================================================================"

TOTAL=$((INSTALLED + SKIPPED + FAILED))

echo -e "✅ ${GREEN}INSTALLED${NC}: $INSTALLED"
echo -e "⏭️  ${YELLOW}SKIPPED${NC}: $SKIPPED"
echo -e "❌ ${RED}FAILED${NC}: $FAILED"
echo -e "📊 ${BLUE}TOTAL ACTIONS${NC}: $TOTAL"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "🎉 ${GREEN}SETUP COMPLETED SUCCESSFULLY!${NC}"
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Restart your terminal to load new environment variables"
    echo "   2. cd $PROJECT_ROOT/example && npm run check-requirements (verify setup)"
    echo "   3. cd $PROJECT_ROOT/example && npm run android (test Android build)"
    echo "   4. cd $PROJECT_ROOT/example && npm run ios (test iOS build - macOS only)"
    EXIT_CODE=0
else
    echo -e "⚠️  ${YELLOW}SETUP COMPLETED WITH ISSUES${NC}"
    echo ""
    echo "🔧 Manual steps may be required:"
    echo "   • Check failed installations above"
    echo "   • Install missing tools manually"
    echo "   • Set environment variables"
    echo "   • Restart terminal and run: npm run check-requirements"
    EXIT_CODE=1
fi

echo ""
echo "📝 Setup completed on $(date)"
echo "🔍 For troubleshooting, run: npm run check-requirements"
echo ""

exit $EXIT_CODE
