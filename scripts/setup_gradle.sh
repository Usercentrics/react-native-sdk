#!/bin/sh -xe

GRADLE_VERSION=$1

mkdir -p ci-cache/gradle
cd ci-cache/gradle

curl -L -s "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" \
     --output "gradle-$GRADLE_VERSION-bin.zip"
unzip -qq "gradle-$GRADLE_VERSION-bin.zip"
rm "gradle-$GRADLE_VERSION-bin.zip"

cd ../../

"./ci-cache/gradle/gradle-$GRADLE_VERSION/bin/gradle" wrapper --gradle-version "$GRADLE_VERSION" --distribution-type all
