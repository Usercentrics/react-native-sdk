plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.facebook.react")
}

android {
    ndkVersion = versions.versions.ndk.get()
    buildToolsVersion = versions.versions.buildTools.get()
    compileSdk = versions.versions.compileSdk.get().toInt()

    namespace = "com.usercentrics.reactnativesdk.sample"
    defaultConfig {
        applicationId = "com.usercentrics.reactnativesdk.sample"
        minSdk = versions.versions.minSdk.get().toInt()
        targetSdk = versions.versions.targetSdk.get().toInt()
        versionCode = 1
        versionName = "1.0"

        val isNewArchEnabled = project.findProperty("newArchEnabled") == "true"
        val isHermesEnabled = project.findProperty("hermesEnabled") != "false"
        buildConfigField("boolean", "IS_NEW_ARCHITECTURE_ENABLED", isNewArchEnabled.toString())
        buildConfigField("boolean", "IS_HERMES_ENABLED", isHermesEnabled.toString())

        ndk {
            abiFilters += setOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }

    buildTypes {
        debug {
            isDebuggable = true
            packagingOptions {
                jniLibs.useLegacyPackaging = false
            }
        }
        release { isMinifyEnabled = false }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildFeatures {
        buildConfig = true
    }

    packaging {
        jniLibs {
            pickFirsts += "**/libjscexecutor.so"
            pickFirsts += "**/libhermes.so"
            pickFirsts += "**/libreactnativejni.so"
            pickFirsts += "**/libreact_featureflagsjni.so"
            useLegacyPackaging = false
        }
    }
}

configurations.all {
    resolutionStrategy {
        force(versions.react.native)
        force(versions.hermes.engine)
    }
}

dependencies {
    // SDK Usercentrics
    implementation(project(":react-native-usercentrics"))

    // React Native
    implementation(versions.react.android)

    implementation(project(":react-native-webview"))
    implementation(project(":react-native-screens"))
    implementation(project(":react-native-safe-area-context"))

    if (project.findProperty("hermesEnabled") != "false") {
        debugImplementation(versions.hermes.android) {
            exclude(group = "com.facebook.fbjni")
        }
    }

    debugImplementation(versions.bundles.flipper.debug)
}

react {
    jsRootDir = file("${rootDir}/../src")
}

// ===================================================================================================
// AUTOLINKING AUTOMATION
// ===================================================================================================
// Include the external autolinking configuration file
// This file contains the generateAutolinking task and automation logic
// ===================================================================================================
apply(from = "${rootDir}/plugin/autolinking.gradle.kts")

subprojects {
    afterEvaluate {
        if (hasProperty("android")) {
            android {
                defaultConfig {
                    minSdk = 24
                }
            }
        }
    }
}
