package com.usercentrics.reactnative

import com.facebook.react.TurboReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager
import com.usercentrics.reactnative.api.UsercentricsProxyImpl

class RNUsercentricsPackage : TurboReactPackage() {

    private val usercentricsProxy = UsercentricsProxyImpl()

    override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? {
        return if (name == RNUsercentricsModule.NAME) {
            val reactContextProvider = ReactContextProviderImpl(reactContext)
            RNUsercentricsModule(reactContext, usercentricsProxy, reactContextProvider)
        } else {
            null
        }
    }

    override fun getReactModuleInfoProvider(): ReactModuleInfoProvider {
        return ReactModuleInfoProvider {
            mapOf(
                RNUsercentricsModule.NAME to ReactModuleInfo(
                    RNUsercentricsModule.NAME,
                    RNUsercentricsModule::class.java.name,
                    false,
                    false,
                    true,
                    false,
                    true, //BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
                )
            )
        }
    }

    override fun createViewManagers(reactContext: ReactApplicationContext): MutableList<ViewManager<*, *>> {
        return mutableListOf()
    }
}
