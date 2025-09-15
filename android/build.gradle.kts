plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
    id("com.facebook.react") version "0.81.0" apply false
}

val usercentricsVersion = "2.22.2"

android {
    namespace = "com.usercentrics.reactnative"
    compileSdk = 34

    defaultConfig {
        minSdk = 24
        targetSdk = 34
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("proguard-rules.pro")
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    buildFeatures {
        buildConfig = true
    }

    packagingOptions {
        jniLibs {
            useLegacyPackaging = false
        }
    }
}

dependencies {
    implementation("com.facebook.react:react-native:0.81.0")
    implementation("com.usercentrics.sdk:usercentrics-ui:$usercentricsVersion")

    androidTestImplementation("io.mockk:mockk-android:1.12.0")
    androidTestImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit-ktx:1.1.3")
    androidTestImplementation("androidx.test:runner:1.4.0")
    androidTestImplementation("androidx.test:rules:1.4.0")
}