package com.usercentrics.reactnativeusercentrics

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxyImpl

class RNUsercentricsPackage : ReactPackage {

    private val usercentricsProxy = UsercentricsProxyImpl()

    override fun createViewManagers(reactContext: ReactApplicationContext): MutableList<ViewManager<*, *>> {
        return mutableListOf()
    }

    override fun createNativeModules(reactContext: ReactApplicationContext): MutableList<NativeModule> {
        val reactContextProvider = ReactContextProviderImpl(reactContext)
        return mutableListOf(RNUsercentricsModule(reactContext, usercentricsProxy, reactContextProvider))
    }
}
