plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

val usercentricsVersion = "2.23.3"
val reactNativeVersion = "0.79.6"

android {
    namespace = "com.usercentrics.reactnative"
    compileSdk = 34

    defaultConfig {
        minSdk = 24
        targetSdk = 34
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("proguard-rules.pro")

        val isNewArchEnabled = project.findProperty("newArchEnabled") == "true"
        val isHermesEnabled = project.findProperty("hermesEnabled") == "true"
        
        buildConfigField("boolean", "IS_NEW_ARCHITECTURE_ENABLED", isNewArchEnabled.toString())
        buildConfigField("boolean", "IS_HERMES_ENABLED", isHermesEnabled.toString())

        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }

        // Only configure CMake if New Architecture is enabled
        if (isNewArchEnabled) {
            externalNativeBuild {
                cmake {
                    cppFlags += listOf("-std=c++20", "-fexceptions", "-frtti")
                    arguments += listOf(
                        "-DANDROID_STL=c++_shared"
                    )
                }
            }
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

    // External native build (CMake) path
    if (true) {
        externalNativeBuild {
            cmake {
                path = file("src/main/jni/CMakeLists.txt")
                version = "3.22.1"
            }
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