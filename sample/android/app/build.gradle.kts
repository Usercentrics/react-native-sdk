plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.facebook.react")
}

/**
 * Set this to true to Run Proguard on Release builds to minify the Java bytecode.
 */
val jscFlavor = "org.webkit:android-jsc:+"

android {
    ndkVersion = libs.versions.ndk.get()
    buildToolsVersion = libs.versions.build.tools.get()
    compileSdk = libs.versions.compile.sdk.get().toInt()

    namespace = "com.usercentrics.reactnativesdk.sample"
    defaultConfig {
        applicationId = "com.usercentrics.reactnativesdk.sample"
        minSdk = libs.versions.min.sdk.get().toInt()
        targetSdk = libs.versions.target.sdk.get().toInt()
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isDebuggable = true
            isCrunchPngs = false
        }
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        buildConfig = true
    }
}

dependencies {
    implementation(libs.react.native)

    val hermesEnabled = project.ext.get("hermesEnabled") as String
    if (hermesEnabled.toBoolean()) {
        implementation(libs.hermes.android)
    } else {
        implementation(jscFlavor)
    }
}

apply(from = file("../../node_modules/@react-native-community/cli-platform-android/native_modules.gradle"))
val applyNativeModulesAppBuildGradle: groovy.lang.Closure<Any> by extra
applyNativeModulesAppBuildGradle(project)
