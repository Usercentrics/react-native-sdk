#include <jni.h>
#include <jsi/jsi.h>
#include <fbjni/fbjni.h>
#include <ReactCommon/CallInvokerHolder.h>
#include <ReactCommon/TurboModuleUtils.h>

namespace facebook {
namespace react {

// This is a minimal C++ TurboModule bridge that delegates to the Kotlin implementation
// The actual TurboModule implementation is in RNUsercentricsModule.kt

extern "C" JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *) {
    return facebook::jni::initialize(vm, [] {
        // No additional initialization needed
        // The Kotlin TurboModule will be loaded via TurboReactPackage
    });
}

} // namespace react
} // namespace facebook

