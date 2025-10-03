#!/usr/bin/env node

/**
 * Script to publish a local version of the Usercentrics React Native SDK
 * Usage: node scripts/publish-local.js [version]
 * Example: node scripts/publish-local.js 2.24.0-local
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Colors for console output
const colors = {
    red: '\x1b[31m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    reset: '\x1b[0m'
};

// Helper functions for colored output
const printInfo = (message) => console.log(`${colors.blue}ℹ️  ${message}${colors.reset}`);
const printSuccess = (message) => console.log(`${colors.green}✅ ${message}${colors.reset}`);
const printWarning = (message) => console.log(`${colors.yellow}⚠️  ${message}${colors.reset}`);
const printError = (message) => console.log(`${colors.red}❌ ${message}${colors.reset}`);

// Get version from command line arguments
const newVersion = process.argv[2];

if (!newVersion) {
    printError('Version parameter is required!');
    console.log('Usage: node scripts/publish-local.js [version]');
    console.log('Example: node scripts/publish-local.js 2.24.0-local');
    process.exit(1);
}

// Check if we're in the correct directory
const packageJsonPath = path.join(process.cwd(), 'package.json');
if (!fs.existsSync(packageJsonPath)) {
    printError('package.json not found. Make sure you\'re running this script from the SDK root directory.');
    process.exit(1);
}

let originalVersion = '';
let packageJson = {};

try {
    printInfo('Starting local SDK publishing process...');
    printInfo(`Target version: ${newVersion}`);

    // Read and backup original package.json
    packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
    originalVersion = packageJson.version;
    printInfo(`Original version: ${originalVersion}`);

    // Function to restore original version
    const restoreVersion = () => {
        printInfo(`Restoring original version: ${originalVersion}`);
        packageJson.version = originalVersion;
        fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2) + '\n');
    };

    // Set up cleanup on exit
    process.on('exit', restoreVersion);
    process.on('SIGINT', () => {
        restoreVersion();
        process.exit(1);
    });
    process.on('SIGTERM', () => {
        restoreVersion();
        process.exit(1);
    });

    // Update version in package.json
    printInfo(`Updating package.json version to: ${newVersion}`);
    packageJson.version = newVersion;
    fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2) + '\n');

    // Clean previous build
    printInfo('Cleaning previous build...');
    try {
        execSync('rm -rf lib/', { stdio: 'inherit' });
    } catch (error) {
        // Ignore error if lib directory doesn't exist
    }

    // Compile TypeScript
    printInfo('Compiling TypeScript...');
    try {
        execSync('npm run compile', { stdio: 'inherit' });
        printSuccess('TypeScript compilation completed');
    } catch (error) {
        printError('TypeScript compilation failed!');
        process.exit(1);
    }

    // Create npm package
    printInfo('Creating npm package...');
    const packOutput = execSync('npm pack', { encoding: 'utf8' });
    const packageFile = packOutput.trim().split('\n').pop();

    if (!packageFile) {
        printError('Failed to create npm package!');
        process.exit(1);
    }

    printSuccess(`Package created: ${packageFile}`);

    // Get absolute path of the package
    const packagePath = path.resolve(packageFile);
    printInfo(`Package path: ${packagePath}`);

    // Display installation instructions
    console.log('');
    printSuccess('Local SDK package created successfully!');
    console.log('');
    printInfo('To install this local version in your React Native project:');
    console.log('  cd /path/to/your/react-native-project');
    console.log('  npm uninstall @usercentrics/react-native-sdk');
    console.log(`  npm install ${packagePath}`);
    console.log('');
    printInfo('Or use the absolute path:');
    console.log(`  npm install ${packagePath}`);
    console.log('');
    printWarning('Remember: This is a local version for testing purposes only.');
    printWarning('Don\'t forget to test thoroughly before publishing to npm registry.');

} catch (error) {
    printError(`An error occurred: ${error.message}`);
    process.exit(1);
}
