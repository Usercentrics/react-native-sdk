rootProject.name = "example"

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    plugins {
        id("com.android.application") version "8.5.2"
        id("com.android.library") version "8.5.2"
        id("org.jetbrains.kotlin.android") version "1.9.22"
        id("com.facebook.react") version "0.78.3"
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
    }
}

include(":app")
include(":react-native-usercentrics")
project(":react-native-usercentrics").projectDir = file("../../android")

includeBuild("../node_modules/@react-native/gradle-plugin")