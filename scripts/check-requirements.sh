#!/bin/bash
# Script to check all project requirements and generate a comprehensive report

echo "🔍 USERCENTRICS REACT NATIVE SDK - REQUIREMENTS CHECK"
echo "=================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Status counters
PASSED=0
FAILED=0
WARNINGS=0

# Function to print status
print_status() {
    local status=$1
    local message=$2
    local details=$3
    
    if [ "$status" = "PASS" ]; then
        echo -e "✅ ${GREEN}PASS${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${BLUE}ℹ️  $details${NC}"
        ((PASSED++))
    elif [ "$status" = "FAIL" ]; then
        echo -e "❌ ${RED}FAIL${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${RED}⚠️  $details${NC}"
        ((FAILED++))
    elif [ "$status" = "WARN" ]; then
        echo -e "⚠️  ${YELLOW}WARN${NC} - $message"
        [ ! -z "$details" ] && echo -e "   ${YELLOW}💡 $details${NC}"
        ((WARNINGS++))
    fi
    echo ""
}

# Function to check version compatibility
check_version() {
    local current=$1
    local required=$2
    local name=$3
    
    if [ -z "$current" ]; then
        print_status "FAIL" "$name not found" "Please install $name"
        return 1
    fi
    
    # Simple version comparison for major.minor
    current_major=$(echo $current | cut -d. -f1)
    current_minor=$(echo $current | cut -d. -f2)
    required_major=$(echo $required | cut -d. -f1)
    required_minor=$(echo $required | cut -d. -f2)
    
    # Store version for logging
    version_log=$(echo "Version check: $current vs $required")
    eval "echo $version_log"
    
    if [ "$current_major" -gt "$required_major" ] || 
       ([ "$current_major" -eq "$required_major" ] && [ "$current_minor" -ge "$required_minor" ]); then
        print_status "PASS" "$name version $current" "Required: >= $required"
        return 0
    else
        print_status "FAIL" "$name version $current is too old" "Required: >= $required"
        return 1
    fi
}

# Detect project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "📂 Project Root: $PROJECT_ROOT"
echo ""

# ============================================================================
echo "🔧 DEVELOPMENT ENVIRONMENT"
echo "============================================================================"

# Check Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version | sed 's/v//')
    check_version "$NODE_VERSION" "18.0" "Node.js"
else
    print_status "FAIL" "Node.js not found" "Install Node.js >= 18.0"
fi

# Check npm
if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    check_version "$NPM_VERSION" "9.0" "npm"
else
    print_status "FAIL" "npm not found" "Install npm >= 9.0"
fi

# Check TypeScript
if command -v tsc >/dev/null 2>&1; then
    TS_VERSION=$(tsc --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    check_version "$TS_VERSION" "5.1" "TypeScript"
else
    print_status "WARN" "TypeScript not found globally" "Will use local version from node_modules"
fi

# ============================================================================
echo "☕ JAVA ENVIRONMENT"
echo "============================================================================"

# Check Java
if command -v java >/dev/null 2>&1; then
    JAVA_VERSION=$(java -version 2>&1 | head -n1 | grep -o '[0-9]\+\.[0-9]\+' | head -1)
    if [ -z "$JAVA_VERSION" ]; then
        # Try alternative format (Java 11+)
        JAVA_VERSION=$(java -version 2>&1 | head -n1 | grep -o '[0-9]\+' | head -1)
        if [ "$JAVA_VERSION" -ge 17 ]; then
            print_status "PASS" "Java version $JAVA_VERSION" "Required: >= 17"
        else
            print_status "FAIL" "Java version $JAVA_VERSION is too old" "Required: >= 17"
        fi
    else
        check_version "$JAVA_VERSION" "17.0" "Java"
    fi
    
    # Check JAVA_HOME
    if [ ! -z "$JAVA_HOME" ]; then
        print_status "PASS" "JAVA_HOME is set" "$JAVA_HOME"
    else
        print_status "WARN" "JAVA_HOME not set" "May cause build issues"
    fi
else
    print_status "FAIL" "Java not found" "Install Java JDK >= 17"
fi

# ============================================================================
echo "🤖 ANDROID ENVIRONMENT"
echo "============================================================================"

# Check Android SDK
if [ ! -z "$ANDROID_HOME" ] || [ ! -z "$ANDROID_SDK_ROOT" ]; then
    SDK_ROOT=${ANDROID_HOME:-$ANDROID_SDK_ROOT}
    print_status "PASS" "Android SDK found" "$SDK_ROOT"
    
    # Check SDK tools
    if [ -f "$SDK_ROOT/platform-tools/adb" ]; then
        ADB_VERSION=$($SDK_ROOT/platform-tools/adb version 2>&1 | head -1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
        print_status "PASS" "ADB found" "Version: $ADB_VERSION"
    else
        print_status "FAIL" "ADB not found" "Install Android SDK Platform Tools"
    fi
    
    # Check for Android 34+ (required for compileSdkVersion and targetSdk 34)
    if [ -d "$SDK_ROOT/platforms/android-34" ]; then
        print_status "PASS" "Android SDK Platform found" "API 34 available"
    elif [ -d "$SDK_ROOT/platforms/android-33" ]; then
        print_status "WARN" "Android SDK Platform found" "API 33 available (API 34 recommended for compileSdkVersion 34)"
    else
        print_status "FAIL" "Android SDK Platform missing" "Install Android API 34 or higher"
    fi
    
    # Check build tools
    if [ -d "$SDK_ROOT/build-tools" ] && [ "$(ls -A $SDK_ROOT/build-tools)" ]; then
        LATEST_BUILD_TOOLS=$(ls $SDK_ROOT/build-tools | sort -V | tail -1)
        print_status "PASS" "Android Build Tools found" "Latest: $LATEST_BUILD_TOOLS"
    else
        print_status "FAIL" "Android Build Tools missing" "Install Android SDK Build Tools"
    fi
    
    # Check CMake
    if [ -d "$SDK_ROOT/cmake" ] && [ "$(ls -A $SDK_ROOT/cmake)" ]; then
        CMAKE_VERSION=$(ls $SDK_ROOT/cmake | sort -V | tail -1)
        print_status "PASS" "CMake found" "Version: $CMAKE_VERSION"
    else
        print_status "FAIL" "CMake missing" "Install CMake via Android SDK Manager"
    fi
    
    # Check NDK
    if [ -d "$SDK_ROOT/ndk" ] && [ "$(ls -A $SDK_ROOT/ndk)" ]; then
        NDK_VERSION=$(ls $SDK_ROOT/ndk | sort -V | tail -1)
        print_status "PASS" "Android NDK found" "Version: $NDK_VERSION"
    else
        print_status "FAIL" "Android NDK missing" "Install Android NDK via SDK Manager"
    fi
    
else
    print_status "FAIL" "Android SDK not found" "Set ANDROID_HOME or ANDROID_SDK_ROOT environment variable"
fi

# Check Gradle
if command -v gradle >/dev/null 2>&1; then
    GRADLE_VERSION=$(gradle --version | grep "Gradle" | grep -o '[0-9]\+\.[0-9]\+')
    check_version "$GRADLE_VERSION" "8.2" "Gradle"
else
    print_status "WARN" "Gradle not found globally" "Will use Gradle Wrapper"
fi

# Check Kotlin
if command -v kotlin >/dev/null 2>&1; then
    KOTLIN_VERSION=$(kotlin -version 2>&1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    check_version "$KOTLIN_VERSION" "1.9.22" "Kotlin"
    # Note: Kotlin 2.0.21 is recommended for this project
    if [ ! -z "$KOTLIN_VERSION" ]; then
        KOTLIN_MAJOR=$(echo $KOTLIN_VERSION | cut -d. -f1)
        if [ "$KOTLIN_MAJOR" -ge 2 ]; then
            print_status "PASS" "Kotlin 2.0+ detected" "Kotlin 2.0.21 is recommended"
        fi
    fi
else
    print_status "WARN" "Kotlin not found globally" "Will use version from Gradle (Kotlin 2.0.21 recommended)"
fi

# ============================================================================
echo "🍎 iOS ENVIRONMENT (macOS only)"
echo "============================================================================"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Check Xcode
    if command -v xcodebuild >/dev/null 2>&1; then
        XCODE_VERSION=$(xcodebuild -version | head -1 | grep -o '[0-9]\+\.[0-9]\+')
        check_version "$XCODE_VERSION" "15.0" "Xcode"
        
        # Check iOS SDK
        IOS_SDK=$(xcodebuild -showsdks | grep iphoneos | tail -1 | grep -o '[0-9]\+\.[0-9]\+')
        if [ ! -z "$IOS_SDK" ]; then
            print_status "PASS" "iOS SDK found" "Version: $IOS_SDK"
        else
            print_status "WARN" "iOS SDK version could not be determined"
        fi
    else
        print_status "FAIL" "Xcode not found" "Install Xcode from App Store"
    fi
    
    # Check CocoaPods
    if command -v pod >/dev/null 2>&1; then
        POD_VERSION=$(pod --version)
        check_version "$POD_VERSION" "1.12" "CocoaPods"
    else
        print_status "FAIL" "CocoaPods not found" "Install: sudo gem install cocoapods"
    fi
    
    # Check iOS Simulator
    if command -v xcrun >/dev/null 2>&1; then
        SIMULATORS=$(xcrun simctl list devices available 2>/dev/null | grep "iPhone" | wc -l)
        if [ "$SIMULATORS" -gt 0 ]; then
            print_status "PASS" "iOS Simulators available" "$SIMULATORS simulators found"
        else
            print_status "WARN" "No iOS Simulators found" "Install iOS Simulators in Xcode"
        fi
    fi
else
    print_status "WARN" "iOS development not available" "macOS required for iOS development"
fi

# ============================================================================
echo "📱 REACT NATIVE ENVIRONMENT"
echo "============================================================================"

# Check React Native CLI
if command -v npx >/dev/null 2>&1; then
    if npx react-native --version >/dev/null 2>&1; then
        RN_CLI_VERSION=$(npx react-native --version | head -1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
        print_status "PASS" "React Native CLI available" "Version: $RN_CLI_VERSION"
    else
        print_status "WARN" "React Native CLI not found" "Will be installed when needed"
    fi
else
    print_status "FAIL" "npx not available" "Reinstall Node.js and npm"
fi

# Check Metro
if [ -f "$PROJECT_ROOT/sample/node_modules/.bin/metro" ]; then
    print_status "PASS" "Metro bundler found" "Available in sample project"
else
    print_status "WARN" "Metro bundler not found" "Run npm install in sample directory"
fi

# ============================================================================
echo "📦 PROJECT DEPENDENCIES"
echo "============================================================================"

# Check root dependencies
if [ -f "$PROJECT_ROOT/package.json" ]; then
    print_status "PASS" "Root package.json found" "Project structure OK"
    
    if [ -d "$PROJECT_ROOT/node_modules" ]; then
        print_status "PASS" "Root node_modules found" "Dependencies installed"
    else
        print_status "FAIL" "Root node_modules missing" "Run: npm install --legacy-peer-deps"
    fi
else
    print_status "FAIL" "Root package.json missing" "Invalid project structure"
fi

# Check sample dependencies
if [ -f "$PROJECT_ROOT/sample/package.json" ]; then
    print_status "PASS" "Sample package.json found" "Sample project OK"
    
    if [ -d "$PROJECT_ROOT/sample/node_modules" ]; then
        print_status "PASS" "Sample node_modules found" "Sample dependencies installed"
        
        # Check if patches are applied
        if [ -f "$PROJECT_ROOT/sample/node_modules/react-native-screens/android/build.gradle" ]; then
            if grep -q "minSdkVersion 23" "$PROJECT_ROOT/sample/node_modules/react-native-screens/android/build.gradle"; then
                print_status "PASS" "Patches applied successfully" "react-native-screens patched"
            else
                print_status "WARN" "Patches may not be applied" "Run: npm run postinstall in sample"
            fi
        fi
    else
        print_status "FAIL" "Sample node_modules missing" "Run: cd sample && npm install --legacy-peer-deps"
    fi
else
    print_status "FAIL" "Sample package.json missing" "Invalid project structure"
fi

# Check legacy-sample dependencies
if [ -f "$PROJECT_ROOT/legacy-sample/package.json" ]; then
    print_status "PASS" "Legacy-sample package.json found" "Legacy-sample project OK"
    
    if [ -d "$PROJECT_ROOT/legacy-sample/node_modules" ]; then
        print_status "PASS" "Legacy-sample node_modules found" "Legacy-sample dependencies installed"
    else
        print_status "FAIL" "Legacy-sample node_modules missing" "Run: cd legacy-sample && npm install --legacy-peer-deps"
    fi
else
    print_status "WARN" "Legacy-sample package.json missing" "Legacy-sample project not found"
fi

# Check compiled TypeScript
if [ -d "$PROJECT_ROOT/lib" ]; then
    print_status "PASS" "TypeScript compiled" "lib directory exists"
else
    print_status "WARN" "TypeScript not compiled" "Run: npm run compile"
fi

# ============================================================================
echo "🔧 DEVELOPMENT TOOLS"
echo "============================================================================"

# Check Git
if command -v git >/dev/null 2>&1; then
    GIT_VERSION=$(git --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    print_status "PASS" "Git found" "Version: $GIT_VERSION"
else
    print_status "WARN" "Git not found" "Install Git for version control"
fi

# Check Watchman (recommended for React Native)
if command -v watchman >/dev/null 2>&1; then
    WATCHMAN_VERSION=$(watchman --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    print_status "PASS" "Watchman found" "Version: $WATCHMAN_VERSION"
else
    print_status "WARN" "Watchman not found" "Install for better file watching: brew install watchman"
fi

# Check Android device/emulator
if command -v adb >/dev/null 2>&1; then
    DEVICES=$(adb devices | grep -v "List of devices" | grep -c "device$")
    if [ "$DEVICES" -gt 0 ]; then
        print_status "PASS" "Android devices connected" "$DEVICES device(s) found"
    else
        print_status "WARN" "No Android devices connected" "Connect device or start emulator"
    fi
else
    print_status "WARN" "ADB not in PATH" "Add Android SDK platform-tools to PATH"
fi

# ============================================================================
echo "📋 PROJECT SPECIFIC REQUIREMENTS"
echo "============================================================================"

# Check project versions from package.json
if [ -f "$PROJECT_ROOT/package.json" ]; then
    PROJECT_RN_VERSION=$(grep '"react-native"' "$PROJECT_ROOT/package.json" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    PROJECT_REACT_VERSION=$(grep '"react"' "$PROJECT_ROOT/package.json" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    
    print_status "PASS" "React Native version" "$PROJECT_RN_VERSION (from package.json)"
    print_status "PASS" "React version" "$PROJECT_REACT_VERSION (from package.json)"
fi

# Check Gradle wrapper version
if [ -f "$PROJECT_ROOT/sample/android/gradle/wrapper/gradle-wrapper.properties" ]; then
    GRADLE_WRAPPER_VERSION=$(grep "distributionUrl" "$PROJECT_ROOT/sample/android/gradle/wrapper/gradle-wrapper.properties" | grep -o '[0-9]\+\.[0-9]\+')
    print_status "PASS" "Gradle Wrapper version" "$GRADLE_WRAPPER_VERSION"
else
    print_status "WARN" "Gradle wrapper properties not found"
fi

# Check Android Gradle Plugin version
if [ -f "$PROJECT_ROOT/sample/android/build.gradle" ]; then
    AGP_VERSION=$(grep "com.android.tools.build:gradle" "$PROJECT_ROOT/sample/android/build.gradle" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    if [ ! -z "$AGP_VERSION" ]; then
        print_status "PASS" "Android Gradle Plugin version" "$AGP_VERSION"
    fi
fi

# ============================================================================
echo "📊 SUMMARY REPORT"
echo "============================================================================"

TOTAL=$((PASSED + FAILED + WARNINGS))

echo -e "✅ ${GREEN}PASSED${NC}: $PASSED"
echo -e "❌ ${RED}FAILED${NC}: $FAILED"
echo -e "⚠️  ${YELLOW}WARNINGS${NC}: $WARNINGS"
echo -e "📊 ${BLUE}TOTAL CHECKS${NC}: $TOTAL"
echo ""

if [ $FAILED -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "🎉 ${GREEN}ALL REQUIREMENTS MET!${NC} Your environment is ready for development."
    else
        echo -e "✅ ${GREEN}READY FOR DEVELOPMENT${NC} with $WARNINGS warning(s). Review warnings above."
    fi
    echo ""
    echo "🚀 Next steps:"
    echo "   1. cd $PROJECT_ROOT && npm run install-dependencies"
    echo "   2. cd $PROJECT_ROOT/sample && npm run android"
    EXIT_CODE=0
else
    echo -e "❌ ${RED}REQUIREMENTS NOT MET${NC}. Please fix the $FAILED failed requirement(s) above."
    echo ""
    echo "🤖 AUTOMATED SETUP AVAILABLE:"
    echo -e "   ${GREEN}npm run auto-setup${NC} - Automatically install missing dependencies"
    echo ""
    echo "🔧 Manual fixes:"
    echo "   • Install missing tools using package managers (brew, sdkman, etc.)"
    echo "   • Set environment variables (ANDROID_HOME, JAVA_HOME)"
    echo "   • Run npm install in project directories"
    echo "   • Update outdated versions"
    EXIT_CODE=1
fi

echo ""
echo "📋 AVAILABLE SCRIPTS:"
echo "============================================================================"
echo -e "🤖 ${BLUE}npm run auto-setup${NC}          - Automatically install all dependencies"
echo -e "🔍 ${BLUE}npm run check-requirements${NC}  - Check development environment"
echo -e "🧹 ${BLUE}npm run clean-all-caches${NC}    - Clean all project caches"
echo -e "📦 ${BLUE}npm run install-dependencies${NC} - Install project dependencies"
echo -e "🤖 ${BLUE}npm run run-android${NC}         - Run Android app (kill ports + launch)"

echo ""
echo "📝 This report was generated on $(date)"
echo "🔍 For detailed setup instructions, visit: https://reactnative.dev/docs/environment-setup"
echo ""

exit $EXIT_CODE

exit $EXIT_CODE
