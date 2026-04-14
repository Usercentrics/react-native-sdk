#!/bin/bash
# Install dependencies script for React Native project

echo "📦 Starting dependencies installation..."

# Detect if we are in root or sample folder and define root path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="$(pwd)"

# Detect project root folder
if [[ "$CURRENT_DIR" == *"/sample" ]]; then
    # Running from inside sample folder
    PROJECT_ROOT="$(cd .. && pwd)"
    echo "📍 Detected: running from inside sample folder"
elif [[ -d "$CURRENT_DIR/scripts" && -d "$CURRENT_DIR/sample" ]]; then
    # Running from project root
    PROJECT_ROOT="$CURRENT_DIR"
    echo "📍 Detected: running from project root"
elif [[ -d "$SCRIPT_DIR/../sample" ]]; then
    # Script executed from scripts folder
    PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
    echo "📍 Detected: running from scripts folder"
else
    echo "❌ Error: Could not detect project structure"
    exit 1
fi

echo "📂 Project root folder: $PROJECT_ROOT"

# Install dependencies in root folder
echo "🏠 Installing dependencies in root folder..."
cd "$PROJECT_ROOT"
if npm install; then
    echo "✅ Root dependencies installed successfully"
else
    echo "❌ Failed to install root dependencies"
    exit 1
fi

# Install dependencies in sample folder
if [[ -d "$PROJECT_ROOT/sample" ]]; then
    echo "📱 Installing dependencies in sample folder..."
    cd "$PROJECT_ROOT/sample"
    if npm install; then
        echo "✅ Sample dependencies installed successfully"
    else
        echo "❌ Failed to install sample dependencies"
        exit 1
    fi
fi

# Return to original directory
cd "$CURRENT_DIR"
echo "🎉 All dependencies installed successfully!"
echo "📝 Next steps:"
if [[ -d "$PROJECT_ROOT/sample" ]]; then
    echo "   1. cd $PROJECT_ROOT/sample && npm run android (to run Android)"
    echo "   2. cd $PROJECT_ROOT/sample && npm run ios (to run iOS)"
    echo "   3. cd $PROJECT_ROOT/sample && npm run start (to start Metro bundler)"
fi
