allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = rootProject.layout.buildDirectory.dir(project.name).get()
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Some older plugins (e.g. ota_update) don't declare an Android `namespace`,
// which AGP 8+ requires and otherwise fails the build with
// "Namespace not specified". Patch it in for any module that's missing one.
subprojects {
    fun patchNamespace() {
        val androidExt = project.extensions.findByName("android")
        if (androidExt is com.android.build.gradle.BaseExtension) {
            if (androidExt.namespace == null) {
                androidExt.namespace = "io.flutter.plugins.${project.name.replace("-", "_")}"
            }
        }
    }
    if (project.state.executed) {
        patchNamespace()
    } else {
        afterEvaluate { patchNamespace() }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
