buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath(libs.gradle.plugin)
        classpath(libs.kotlin.plugin)
        classpath(libs.react.native.plugin)
    }
}

allprojects {
    repositories {
        mavenCentral()
        mavenLocal()
        maven {
            url = uri("$rootDir/../node_modules/react-native/android")
        }
        maven {
            url = uri("$rootDir/../node_modules/jsc-android/dist")
        }

        google()
        maven { url = uri("https://www.jitpack.io") }
    }
    
    configurations.all {
        resolutionStrategy {
            force("com.android.tools.build:gradle:8.5.0")
        }
    }
}

subprojects {
    afterEvaluate {
        extensions.findByType<org.jetbrains.kotlin.gradle.dsl.KotlinJvmOptions>()?.let {
            it.jvmTarget = "17"
        }
        
        extensions.findByType<com.android.build.gradle.BaseExtension>()?.let { android ->
            android.compileSdkVersion(34)
            android.buildToolsVersion("34.0.0")
        }
    }
}
