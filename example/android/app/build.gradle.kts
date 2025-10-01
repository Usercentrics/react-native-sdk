plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.facebook.react")
}

android {
    namespace = "com.usercentrics.reactnativesdk.example"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.usercentrics.reactnativesdk.example"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"

        buildConfigField("boolean", "IS_NEW_ARCHITECTURE_ENABLED", "true")
        buildConfigField("boolean", "IS_HERMES_ENABLED", "true")

        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
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
            useLegacyPackaging = false
        }
    }

    sourceSets {
        getByName("main") {
            jniLibs.srcDirs("src/main/jniLibs")
        }
    }
}

configurations.all {
    resolutionStrategy {
        force("com.facebook.react:react-native:0.78.3")
        force("com.facebook.react:hermes-engine:0.78.3")
    }
}

dependencies {
    implementation("com.facebook.react:react-native:0.78.3")
    implementation(project(":react-native-usercentrics"))

    debugImplementation("com.facebook.react:hermes-engine:0.78.3") {
        exclude(group = "com.facebook.fbjni")
    }
    releaseImplementation("com.facebook.react:hermes-engine:0.78.3") {
        exclude(group = "com.facebook.fbjni")
    }

    // AndroidX dependencies
    implementation("androidx.core:core:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.activity:activity:1.8.2")
    implementation("androidx.fragment:fragment:1.6.2")

    // Flipper dependencies
    debugImplementation("com.facebook.flipper:flipper:0.212.0")
    debugImplementation("com.facebook.flipper:flipper-network-plugin:0.212.0")
    debugImplementation("com.facebook.soloader:soloader:0.10.5")
}

// React Native CodeGen configuration
react {
    jsRootDir = file("${rootDir}/../src")
}