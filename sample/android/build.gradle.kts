buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath(libs.gradle.plugin)
        classpath(libs.react.native.plugin)
        classpath(libs.kotlin.plugin)
    }
}

apply(plugin = "com.facebook.react.rootproject")
