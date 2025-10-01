/**
 * ===================================================================================================
 * AUTOLINKING AUTOMATION FOR REACT NATIVE
 * ===================================================================================================
 * This file contains the autolinking task and configuration that automatically generates
 * the autolinking.json file required for React Native's autolinking system.
 * The file is only generated when needed and contains configuration data for all dependencies.
 * ===================================================================================================
 */

/**
 * Task to generate autolinking.json configuration file
 * This task runs the generateAutolinking.js script to create the required autolinking file
 */
tasks.register<Exec>("generateAutolinking") {
    description = "Generates autolinking.json configuration file for React Native autolinking"
    group = "react-native"

    workingDir = file(project.rootDir.parent)
    commandLine("node", "generateAutolinking.js")

    onlyIf {
        val autolinkingEnabled = findProperty("autolinkingEnabled") != "false" // Default to true
        if (!autolinkingEnabled) {
            println("⚠️  Autolinking generation disabled via autolinkingEnabled=false")
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
        val packageTime = if (packageJsonFile.exists()) packageJsonFile.lastModified() else 0L
        val configTime = if (configFile.exists()) configFile.lastModified() else 0L

        if (packageTime > autolinkingTime || configTime > autolinkingTime) {
            println("📝 Input files changed - will regenerate autolinking.json")
            return@onlyIf true
        }

        println("✅ autolinking.json is up to date - skipping generation")
        return@onlyIf false
    }

    inputs.files(
        "${project.rootDir.parent}/package.json",
        "${project.rootDir.parent}/react-native.config.js"
    )

    outputs.file("${project.rootDir}/build/generated/autolinking/autolinking.json")

    doFirst {
        println("🔄 Generating autolinking.json for React Native autolinking...")
    }

    doLast {
        println("✅ autolinking.json generated successfully!")
    }
}

/**
 * Automatic task dependency configuration
 * This ensures that autolinking.json is generated before any build tasks that require it.
 * The configuration runs after all build scripts are evaluated to ensure all tasks exist.
 */
afterEvaluate {
    val newArchEnabled = findProperty("newArchEnabled")
    val autolinkingEnabled = findProperty("autolinkingEnabled") != "false" // Default to true

    // Always configure autolinking automation regardless of New Architecture status
    if (autolinkingEnabled) {
        // Configure for New Architecture tasks (only if New Architecture is enabled)
        if (newArchEnabled == "true" || newArchEnabled == true) {
            tasks.matching {
                it.name.startsWith("generate") && it.name.contains("NewArchitectureFiles")
            }.configureEach {
                dependsOn("generateAutolinking")
            }
            println("🔧 Autolinking automation configured for New Architecture")
        }

        // Always configure for standard React Native tasks
        tasks.named("preBuild") {
            dependsOn("generateAutolinking")
        }

        tasks.matching { it.name == "generateAutolinkingPackageList" }.configureEach {
            dependsOn("generateAutolinking")
        }

        println("🔧 Autolinking automation configured (New Architecture: ${newArchEnabled ?: "disabled"})")
    } else {
        println("⚠️  Autolinking automation disabled via autolinkingEnabled=false")
    }
}
