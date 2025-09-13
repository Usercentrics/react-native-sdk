rootProject.name = "sample"

dependencyResolutionManagement {
    versionCatalogs {
        create("libs") {
            from(files("../../gradle/libs.versions.toml"))
        }
    }
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
    }
}

apply(from = file("../node_modules/@react-native-community/cli-platform-android/native_modules.gradle"))
@Suppress("UNCHECKED_CAST")
val applyNativeModulesSettingsGradle =
    extra["applyNativeModulesSettingsGradle"] as groovy.lang.Closure<Settings>
applyNativeModulesSettingsGradle(settings)

include(":react-native-usercentrics")
project(":react-native-usercentrics").projectDir = File(rootProject.projectDir, "../../android")

include(":react-native-safe-area-context")
project(":react-native-safe-area-context").projectDir =
    File(rootProject.projectDir, "../node_modules/react-native-safe-area-context/android")

include(":react-native-screens")
project(":react-native-screens").projectDir =
    File(rootProject.projectDir, "../node_modules/react-native-screens/android")

include(":react-native-webview")
project(":react-native-webview").projectDir =
    File(rootProject.projectDir, "../node_modules/react-native-webview/android")

includeBuild("../node_modules/@react-native/gradle-plugin")

includeBuild("../node_modules/react-native") {
    dependencySubstitution {
        substitute(module("com.facebook.react:react-android"))
            .using(project(":packages:react-native:ReactAndroid"))
        substitute(module("com.facebook.react:react-native"))
            .using(project(":packages:react-native:ReactAndroid"))
    }
}

include(":app")
