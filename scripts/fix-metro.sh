#!/bin/bash

# ===================================================================================================
# METRO ISSUES FIX SCRIPT
# ===================================================================================================
# This script resolves common Metro bundler issues that occur frequently in React Native projects.
# It handles TreeFS conflicts, port conflicts, cache issues, and Watchman problems.
# ===================================================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if we're in a React Native project
check_rn_project() {
    if [ ! -f "package.json" ] || [ ! -f "metro.config.js" ]; then
        print_error "This doesn't appear to be a React Native project (missing package.json or metro.config.js)"
        print_status "Please run this script from the root of your React Native project"
        exit 1
    fi
}

# Function to kill Metro processes
kill_metro_processes() {
    print_status "Stopping any running Metro processes..."
    
    # Kill Metro processes
    pkill -f "react-native start" 2>/dev/null || true
    pkill -f "metro" 2>/dev/null || true
    pkill -f "node.*metro" 2>/dev/null || true
    
    # Wait a moment for processes to stop
    sleep 2
    
    print_success "Metro processes stopped"
}

# Function to clear Metro and Metro-related caches
clear_metro_caches() {
    print_status "Clearing Metro and related caches..."
    
    # Clear Metro cache
    rm -rf /tmp/metro-* 2>/dev/null || true
    rm -rf /tmp/haste-map-* 2>/dev/null || true
    rm -rf /tmp/react-* 2>/dev/null || true
    
    # Clear local Metro cache
    rm -rf .metro 2>/dev/null || true
    rm -rf node_modules/.cache 2>/dev/null || true
    
    # Clear npm cache
    npm cache clean --force 2>/dev/null || true
    
    print_success "Metro caches cleared"
}

# Function to fix Watchman issues
fix_watchman_issues() {
    print_status "Fixing Watchman issues..."
    
    # Get the current directory (project root)
    PROJECT_ROOT=$(pwd)
    
    # Stop Watchman
    watchman watch-del "$PROJECT_ROOT" 2>/dev/null || true
    
    # Restart Watchman for the project
    watchman watch-project "$PROJECT_ROOT" 2>/dev/null || true
    
    # Clear Watchman cache
    watchman watch-del-all 2>/dev/null || true
    
    print_success "Watchman issues fixed"
}

# Function to fix TreeFS conflicts (node_modules issues)
fix_treefs_conflicts() {
    print_status "Fixing TreeFS conflicts in node_modules..."
    
    # Check if @usercentrics/react-native-sdk exists and is causing conflicts
    if [ -d "node_modules/@usercentrics/react-native-sdk" ]; then
        print_warning "Found @usercentrics/react-native-sdk, removing to fix TreeFS conflicts..."
        rm -rf node_modules/@usercentrics/react-native-sdk
        print_success "Removed conflicting SDK directory"
    fi
    
    # Check for other potential conflicts
    if [ -d "node_modules/@react-native" ]; then
        print_status "Checking for React Native conflicts..."
        # Remove any symlinks that might be causing issues
        find node_modules/@react-native -type l -delete 2>/dev/null || true
    fi
    
    print_success "TreeFS conflicts resolved"
}

# Function to reinstall dependencies
reinstall_dependencies() {
    print_status "Reinstalling dependencies..."
    
    # Remove node_modules and package-lock.json
    rm -rf node_modules
    rm -f package-lock.json
    rm -f yarn.lock
    
    # Install dependencies
    if command -v yarn &> /dev/null; then
        print_status "Using Yarn to install dependencies..."
        yarn install
    else
        print_status "Using npm to install dependencies..."
        npm install
    fi
    
    print_success "Dependencies reinstalled"
}

# Function to check and kill processes using port 8081
kill_port_8081() {
    print_status "Checking for processes using port 8081..."
    
    # Find processes using port 8081
    PORT_PID=$(lsof -ti:8081 2>/dev/null || true)
    
    if [ ! -z "$PORT_PID" ]; then
        print_warning "Found process $PORT_PID using port 8081, killing it..."
        kill -9 $PORT_PID 2>/dev/null || true
        sleep 2
        print_success "Port 8081 freed"
    else
        print_success "Port 8081 is available"
    fi
}

# Function to start Metro with proper configuration
start_metro() {
    print_status "Starting Metro bundler..."
    
    # Start Metro in background
    npx react-native start --reset-cache &
    METRO_PID=$!
    
    # Wait for Metro to start
    print_status "Waiting for Metro to start..."
    sleep 10
    
    # Check if Metro is running
    if ps -p $METRO_PID > /dev/null; then
        print_success "Metro started successfully (PID: $METRO_PID)"
        print_status "Metro is running on http://localhost:8081"
        print_status "Press Ctrl+C to stop Metro"
        
        # Wait for user to stop
        wait $METRO_PID
    else
        print_error "Failed to start Metro"
        exit 1
    fi
}

# Function to run a quick test
test_metro() {
    print_status "Testing Metro connection..."
    
    # Wait a bit for Metro to fully start
    sleep 5
    
    # Test if Metro is responding
    if curl -s http://localhost:8081/status > /dev/null 2>&1; then
        print_success "Metro is responding correctly"
    else
        print_warning "Metro might not be fully ready yet"
    fi
}

# Main function
main() {
    echo "==================================================================================================="
    echo "                    METRO ISSUES FIX SCRIPT"
    echo "==================================================================================================="
    echo ""
    
    # Check if we're in a React Native project
    check_rn_project
    
    print_status "Starting Metro issues resolution..."
    echo ""
    
    # Step 1: Kill existing Metro processes
    kill_metro_processes
    echo ""
    
    # Step 2: Clear all caches
    clear_metro_caches
    echo ""
    
    # Step 3: Fix Watchman issues
    fix_watchman_issues
    echo ""
    
    # Step 4: Fix TreeFS conflicts
    fix_treefs_conflicts
    echo ""
    
    # Step 5: Reinstall dependencies
    reinstall_dependencies
    echo ""
    
    # Step 6: Kill processes using port 8081
    kill_port_8081
    echo ""
    
    # Step 7: Start Metro
    start_metro
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --test         Run a quick test without starting Metro"
        echo "  --kill-only    Only kill Metro processes and clear caches"
        echo ""
        echo "This script fixes common Metro bundler issues:"
        echo "  - TreeFS conflicts in node_modules"
        echo "  - Port 8081 conflicts"
        echo "  - Metro cache issues"
        echo "  - Watchman problems"
        echo "  - Dependency conflicts"
        exit 0
        ;;
    --test)
        check_rn_project
        kill_metro_processes
        clear_metro_caches
        fix_watchman_issues
        fix_treefs_conflicts
        reinstall_dependencies
        kill_port_8081
        print_success "All fixes applied. You can now start Metro manually."
        exit 0
        ;;
    --kill-only)
        check_rn_project
        kill_metro_processes
        clear_metro_caches
        fix_watchman_issues
        kill_port_8081
        print_success "Metro processes killed and caches cleared."
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac
