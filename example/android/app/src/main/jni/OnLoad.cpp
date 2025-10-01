#include <jni.h>
#include <fbjni/fbjni.h>

using namespace facebook;

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *) {
    return jni::initialize(vm, [] {
        // Initialize any additional JNI bindings here if needed
    });
}
