buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath(versions.android.gradle.plugin)
        classpath(versions.kotlin.gradle.plugin)
        classpath(versions.react.native.gradle.plugin)
        classpath("com.google.gms:google-services:4.4.2")
    }
}
