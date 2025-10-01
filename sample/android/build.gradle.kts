buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath(versions.android.gradle.plugin)
        classpath(versions.kotlin.gradle.plugin)
        classpath(versions.react.native.gradle.plugin)
    }
}
