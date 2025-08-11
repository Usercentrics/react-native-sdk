#!/bin/bash
set -e
lsof -i tcp:8081 | awk 'NR!=1 {print $2}' | xargs kill
lsof -i tcp:7007 | awk 'NR!=1 {print $2}' | xargs kill
# adb reverse tcp:8081 tcp:8081
# adb reverse tcp:7007 tcp:7007
# adb reverse tcp:8097 tcp:8097
react-native run-android --no-packager --variant $VARIANT
