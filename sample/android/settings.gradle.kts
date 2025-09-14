rootProject.name = "sample"

dependencyResolutionManagement {
    versionCatalogs {
        create("libs") {
            from(files("../gradle/libs.versions.toml"))
        }
    }
}

apply(from = file("../node_modules/@react-native-community/cli-platform-android/native_modules.gradle"))
val applyNativeModulesSettingsGradle: groovy.lang.Closure<Any> by extra
applyNativeModulesSettingsGradle(settings)

include(":app")
include(":react-native-usercentrics")
project(":react-native-usercentrics").projectDir = file("../../android")
includeBuild("../node_modules/@react-native/gradle-plugin")
