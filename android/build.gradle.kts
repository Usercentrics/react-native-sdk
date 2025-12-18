val usercentricsVersion = "2.24.3"
val reactNativeVersion = "+"

fun BooleanProperty(name: String): Boolean {
    return project.hasProperty(name) && project.property(name) == "true"
}

val isNewArchitectureEnabled = BooleanProperty("newArchEnabled")
val isHermesEnabled = BooleanProperty("hermesEnabled")

plugins {
    id("com.android.library")
    id("kotlin-android")
}

if (isNewArchitectureEnabled) {
    apply(plugin = "com.facebook.react")
}

android {
    namespace = "com.usercentrics.reactnative"
    compileSdk = 34

    defaultConfig {
        minSdk = 24
        targetSdk = 34
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("proguard-rules.pro")

        // BuildConfig flags
        buildConfigField("boolean", "IS_NEW_ARCHITECTURE_ENABLED", isNewArchitectureEnabled.toString())
        buildConfigField("boolean", "IS_HERMES_ENABLED", isHermesEnabled.toString())

        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }

    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main").java.srcDirs(
            "src/main/kotlin",
            "$buildDir/generated/codegen/NativeModules"
        )
    }

    buildFeatures {
        buildConfig = true
    }

    packaging {
        jniLibs {
            useLegacyPackaging = false
        }
    }

}

dependencies {
    implementation("com.facebook.react:react-android:$reactNativeVersion")
    implementation("com.usercentrics.sdk:usercentrics-ui:$usercentricsVersion")

    // Unit tests
    testImplementation("junit:junit:4.13.2")
    testImplementation("io.mockk:mockk:1.13.12")
    testImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.9.0")

    // Instrumented tests
    androidTestImplementation("com.facebook.react:react-android:$reactNativeVersion")
    androidTestImplementation("io.mockk:mockk-android:1.12.0")
    androidTestImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit-ktx:1.1.3")
    androidTestImplementation("androidx.test:runner:1.4.0")
    androidTestImplementation("androidx.test:rules:1.4.0")
}

// Fix for Gradle task dependency issue with React Native autolinking
// This ensures that packageReleaseResources task waits for generateReleaseResValues to complete
afterEvaluate {
    if (project.tasks.findByName("packageReleaseResources") != null && project.tasks.findByName(":usercentrics_react-native-sdk:generateReleaseResValues") != null) {
        project.tasks.named("packageReleaseResources").configure {
            dependsOn(":usercentrics_react-native-sdk:generateReleaseResValues")
        }
    }
}