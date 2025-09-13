plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.facebook.react")
}

android {
    namespace = "com.usercentrics.reactnativesdk.sample"
    ndkVersion = libs.versions.ndk.get()
    compileSdk = libs.versions.compile.sdk.get().toInt()

    buildFeatures {
        buildConfig = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.usercentrics.reactnativesdk.sample"
        minSdk = libs.versions.min.sdk.get().toInt()
        targetSdk = libs.versions.target.sdk.get().toInt()
        versionCode = 1
        versionName = "1.0"

        buildConfigField(
            "boolean",
            "IS_NEW_ARCHITECTURE_ENABLED",
            (findProperty("newArchEnabled") ?: "true").toString()
        )
        buildConfigField(
            "boolean",
            "IS_HERMES_ENABLED",
            (findProperty("hermesEnabled") ?: "true").toString()
        )
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    implementation(libs.react.native)
    implementation(libs.fbjni)
    implementation(libs.hermes.android)

    // React Native dependencies (from node_modules)
    implementation(project(":react-native-safe-area-context"))
    implementation(project(":react-native-screens"))
    implementation(project(":react-native-webview"))
    implementation(project(":react-native-usercentrics"))

    debugImplementation(libs.flipper)
    debugImplementation(libs.flipper.network)
    debugImplementation(libs.flipper.soloader)
}

// ===================================================================================================
// AUTOLINKING AUTOMATION FOR NEW ARCHITECTURE
// ===================================================================================================
tasks.register<Exec>("generateAutolinking") {
    description = "Generates autolinking.json configuration file for React Native New Architecture"
    group = "react-native"

    workingDir = project.rootDir.parentFile
    commandLine("node", "generateAutolinking.js")

    onlyIf {
        val newArchEnabled = findProperty("newArchEnabled")
        if (newArchEnabled != "true" && newArchEnabled != true) {
            return@onlyIf false
        }

        val autolinkingFile = file("${project.rootDir}/build/generated/autolinking/autolinking.json")
        val packageJsonFile = file("${project.rootDir.parent}/package.json")
        val configFile = file("${project.rootDir.parent}/react-native.config.js")

        if (!autolinkingFile.exists()) {
            println("📝 autolinking.json not found - will generate")
            return@onlyIf true
        }

        val autolinkingTime = autolinkingFile.lastModified()
        val packageTime = if (packageJsonFile.exists()) packageJsonFile.lastModified() else 0
        val configTime = if (configFile.exists()) configFile.lastModified() else 0

        if (packageTime > autolinkingTime || configTime > autolinkingTime) {
            println("📝 Input files changed - will regenerate autolinking.json")
            return@onlyIf true
        }

        println("✅ autolinking.json is up to date - skipping generation")
        false
    }

    inputs.files(
        "${project.rootDir.parent}/package.json",
        "${project.rootDir.parent}/react-native.config.js"
    )
    outputs.file("${project.rootDir}/build/generated/autolinking/autolinking.json")

    doFirst {
        println("🔄 Generating autolinking.json for React Native New Architecture...")
    }
    doLast {
        println("✅ autolinking.json generated successfully!")
    }
}

afterEvaluate {
    val newArchEnabled = findProperty("newArchEnabled")
    if (newArchEnabled == "true" || newArchEnabled == true) {
        tasks.matching {
            it.name.startsWith("generate") && it.name.contains("NewArchitectureFiles")
        }.configureEach {
            dependsOn("generateAutolinking")
        }

        tasks.named("preBuild") {
            dependsOn("generateAutolinking")
        }

        tasks.matching { it.name == "generateAutolinkingPackageList" }.configureEach {
            dependsOn("generateAutolinking")
        }

        println("🔧 Autolinking automation configured for New Architecture")
    }
}
