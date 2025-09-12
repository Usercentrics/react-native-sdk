#!/bin/bash
# Complete cache cleanup script for React Native project

echo "🧹 Starting complete cache cleanup..."

# Detect if we are in root, example, or sample folder and define root path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="$(pwd)"

# Detect project root folder
if [[ "$CURRENT_DIR" == *"/example" ]]; then
    # Running from inside example folder
    PROJECT_ROOT="$(cd .. && pwd)"
    echo "📍 Detected: running from inside example folder"
elif [[ "$CURRENT_DIR" == *"/sample" ]]; then
    # Running from inside sample folder
    PROJECT_ROOT="$(cd .. && pwd)"
    echo "📍 Detected: running from inside sample folder"
elif [[ -d "$CURRENT_DIR/scripts" && (-d "$CURRENT_DIR/example" || -d "$CURRENT_DIR/sample") ]]; then
    # Running from project root
    PROJECT_ROOT="$CURRENT_DIR"
    echo "📍 Detected: running from project root"
elif [[ -d "$SCRIPT_DIR/../example" || -d "$SCRIPT_DIR/../sample" ]]; then
    # Script executed from scripts folder
    PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
    echo "📍 Detected: running from scripts folder"
else
    echo "❌ Error: Could not detect project structure"
    exit 1
fi

echo "📂 Project root folder: $PROJECT_ROOT"

# Stop all processes
echo "⏹️  Stopping processes..."
pkill -f metro 2>/dev/null || true
pkill -f node 2>/dev/null || true
pkill -f gradle 2>/dev/null || true

# Clean example project caches
if [[ -d "$PROJECT_ROOT/example" ]]; then
    echo "🗂️  Cleaning example project caches..."
    cd "$PROJECT_ROOT/example"
    rm -rf node_modules
    rm -rf android/build
    rm -rf android/.gradle
    rm -rf android/app/build
    rm -rf .metro
    rm -rf ios/build
    rm -rf ios/Pods
    rm -rf ios/Podfile.lock
fi

# Clean sample project caches
if [[ -d "$PROJECT_ROOT/sample" ]]; then
    echo "🗂️  Cleaning sample project caches..."
    cd "$PROJECT_ROOT/sample"
    npm cache clean --force 2>/dev/null || true
    rm -rf node_modules package-lock.json
    rm -rf android/app/.cxx android/app/build android/build android/.gradle
    rm -rf .metro
    rm -rf ios/build
    rm -rf ios/Pods
    rm -rf ios/Podfile.lock

    # Clean Android with gradlew
    if [[ -f "android/gradlew" ]]; then
        cd android && ./gradlew clean 2>/dev/null || true
        cd ..
    fi
fi

# Clean root folder caches
echo "📁 Cleaning root folder caches..."
cd "$PROJECT_ROOT"
npm cache clean --force 2>/dev/null || true
rm -rf node_modules package-lock.json
rm -rf android/build
rm -rf android/.gradle
rm -rf lib
rm -rf ios/build

# Clean global system caches
echo "🌐 Cleaning global system caches..."
rm -rf ~/.gradle/caches 2>/dev/null || true
rm -rf ~/.android/build-cache 2>/dev/null || true
rm -rf ~/.metro 2>/dev/null || true
rm -rf /tmp/metro-* 2>/dev/null || true
rm -rf /tmp/haste-map-* 2>/dev/null || true
rm -rf /tmp/react-native-* 2>/dev/null || true

# Stop Gradle daemon
echo "⚙️  Stopping Gradle daemon..."
if [[ -d "$PROJECT_ROOT/example/android" ]]; then
    cd "$PROJECT_ROOT/example/android"
    ./gradlew --stop 2>/dev/null || true
fi
if [[ -d "$PROJECT_ROOT/sample/android" ]]; then
    cd "$PROJECT_ROOT/sample/android"
    ./gradlew --stop 2>/dev/null || true
fi

# Return to original directory
cd "$CURRENT_DIR"
echo "✅ Complete cleanup finished!"
echo "📝 Next steps:"
echo "   1. npm run install-dependencies"
if [[ -d "$PROJECT_ROOT/example" ]]; then
    echo "   2. cd $PROJECT_ROOT/example && npm run android"
fi
if [[ -d "$PROJECT_ROOT/sample" ]]; then
    echo "   2. cd $PROJECT_ROOT/sample && npm run android"
fi
