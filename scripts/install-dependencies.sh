#!/bin/bash
# Install dependencies script for React Native project

echo "📦 Starting dependencies installation..."

# Detect if we are in root or example folder and define root path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="$(pwd)"

# Detect project root folder
if [[ "$CURRENT_DIR" == *"/example" ]]; then
    # Running from inside example folder
    PROJECT_ROOT="$(cd .. && pwd)"
    echo "📍 Detected: running from inside example folder"
elif [[ -d "$CURRENT_DIR/scripts" && -d "$CURRENT_DIR/example" ]]; then
    # Running from project root
    PROJECT_ROOT="$CURRENT_DIR"
    echo "📍 Detected: running from project root"
elif [[ -d "$SCRIPT_DIR/../example" ]]; then
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
if npm install --legacy-peer-deps; then
    echo "✅ Root dependencies installed successfully"
else
    echo "❌ Failed to install root dependencies"
    exit 1
fi

# Install dependencies in example folder
echo "📱 Installing dependencies in example folder..."
cd "$PROJECT_ROOT/example"
if npm install --legacy-peer-deps; then
    echo "✅ Example dependencies installed successfully"
else
    echo "❌ Failed to install example dependencies"
    exit 1
fi

# Return to original directory
cd "$CURRENT_DIR"
echo "🎉 All dependencies installed successfully!"
echo "📝 Next steps:"
echo "   1. cd $PROJECT_ROOT/example && npm run android (to run Android)"
echo "   2. cd $PROJECT_ROOT/example && npm run ios (to run iOS)"
echo "   3. cd $PROJECT_ROOT/example && npm run start (to start Metro bundler)"
