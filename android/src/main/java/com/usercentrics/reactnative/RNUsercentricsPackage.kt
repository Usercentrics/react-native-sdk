package com.usercentrics.reactnative

import com.facebook.react.TurboReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModuleList
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager
import com.usercentrics.reactnative.api.UsercentricsProxyImpl

@ReactModuleList(
    nativeModules = [
        RNUsercentricsModule::class,
    ],
)
class RNUsercentricsPackage : TurboReactPackage() {

    private val usercentricsProxy = UsercentricsProxyImpl()

    override fun getModule(s: String, reactApplicationContext: ReactApplicationContext): NativeModule? {
        when (s) {
            RNUsercentricsModule.NAME -> {
                val reactContextProvider = ReactContextProviderImpl(reactApplicationContext)
                return RNUsercentricsModule(reactApplicationContext, usercentricsProxy, reactContextProvider)
            }
        }
        return null
    }

    override fun getReactModuleInfoProvider(): ReactModuleInfoProvider =
        ReactModuleInfoProvider {
            val moduleInfos: MutableMap<String, ReactModuleInfo> = HashMap()
            val isTurboModule = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
            moduleInfos[RNUsercentricsModule.NAME] =
                ReactModuleInfo(
                    RNUsercentricsModule.NAME,
                    RNUsercentricsModule.NAME,
                    false, // canOverrideExistingModule
                    false, // needsEagerInit
                    true, // hasConstants
                    false, // isCxxModule
                    isTurboModule,
                )
            moduleInfos
        }

    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
        return emptyList()
    }
}
