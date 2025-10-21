#include <ReactCommon/JavaTurboModule.h>
#include <ReactCommon/TurboModule.h>
#include <jsi/jsi.h>

namespace facebook {
namespace react {

JSI_EXPORT
std::shared_ptr<TurboModule> RNUsercentricsModule_ModuleProvider(
    const std::string &moduleName,
    const JavaTurboModule::InitParams &params) {
  // This is a placeholder implementation
  // The actual module is implemented in Java/Kotlin
  return nullptr;
}

} // namespace react
} // namespace facebook



