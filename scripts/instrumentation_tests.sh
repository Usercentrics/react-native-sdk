#!/bin/bash -xe

function buildApks() {
  ./gradlew :app:assembleDebug :app:assembleDebugAndroidTest --stacktrace
}

function installTestApk() {
  adb install app/build/outputs/apk/androidTest/debug/app-debug-androidTest.apk
}

function runTest() {
  local test_output=`adb shell am instrument -w -e debug false -e com.usercentrics.sdk.main.test/androidx.test.runner.AndroidJUnitRunner`

  local has_failures=`echo "$test_output" | grep "FAILURES"`
  if [ ! -z "$has_failures" ]; then
    echo "test $test_class FAILED"
    exit 1;
  fi
}

function main() {
  buildApks
  ../scripts/wait_emulator.sh
  installTestApk
  runTest
}

main
