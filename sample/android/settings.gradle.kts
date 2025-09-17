pluginManagement {
    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
        maven { url = uri("$rootDir/../node_modules/@react-native/gradle-plugin") }
    }

    plugins {
        id("org.jetbrains.kotlin.android") version "2.1.20"
        id("com.facebook.react") version "0.79.6"
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("$rootDir/../node_modules/@react-native/gradle-plugin") }
        maven { url = uri("https://www.jitpack.io") }
    }

    versionCatalogs {
        create("versions") {
            from(files("gradle/libs.versions.toml"))
        }
    }
}

rootProject.name = "sample"

include(":app")
include(":react-native-webview")
include(":react-native-screens")
include(":react-native-usercentrics")
include(":react-native-safe-area-context")

project(":react-native-usercentrics").projectDir = file("../../android")
project(":react-native-webview").projectDir = file("../node_modules/react-native-webview/android")
project(":react-native-screens").projectDir = file("../node_modules/react-native-screens/android")
project(":react-native-safe-area-context").projectDir = file("../node_modules/react-native-safe-area-context/android")
includeBuild("../node_modules/@react-native/gradle-plugin")

