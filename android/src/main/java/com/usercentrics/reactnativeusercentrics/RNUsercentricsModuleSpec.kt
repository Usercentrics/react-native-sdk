package com.usercentrics.reactnativeusercentrics

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.turbomodule.core.interfaces.TurboModule
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = RNUsercentricsModuleSpec.NAME)
abstract class RNUsercentricsModuleSpec internal constructor(context: ReactApplicationContext) :
    com.facebook.react.bridge.ReactContextBaseJavaModule(context), TurboModule {

    @ReactMethod
    abstract fun configure(options: ReadableMap)

    @ReactMethod
    abstract fun isReady(promise: Promise)

    @ReactMethod
    abstract fun showFirstLayer(options: ReadableMap?, promise: Promise)

    @ReactMethod
    abstract fun showSecondLayer(options: ReadableMap?, promise: Promise)

    @ReactMethod
    abstract fun restoreUserSession(controllerId: String, promise: Promise)

    @ReactMethod
    abstract fun getControllerId(promise: Promise)

    @ReactMethod
    abstract fun clearUserSession(promise: Promise)

    @ReactMethod
    abstract fun getConsents(promise: Promise)

    @ReactMethod
    abstract fun getCMPData(promise: Promise)

    @ReactMethod
    abstract fun getAdditionalConsentModeData(promise: Promise)

    @ReactMethod
    abstract fun getTCFData(promise: Promise)

    @ReactMethod
    abstract fun getUserSessionData(promise: Promise)

    @ReactMethod
    abstract fun getUSPData(promise: Promise)

    @ReactMethod
    abstract fun getABTestingVariant(promise: Promise)

    @ReactMethod
    abstract fun setCMPId(id: Int)

    @ReactMethod
    abstract fun setABTestingVariant(variant: String)

    @ReactMethod
    abstract fun changeLanguage(language: String, promise: Promise)

    @ReactMethod
    abstract fun acceptAll(consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun acceptAllForTCF(fromLayer: Int, consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun denyAll(consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun denyAllForTCF(fromLayer: Int, consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun saveDecisions(decisions: ReadableArray, consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun saveDecisionsForTCF(
        tcfDecisions: ReadableMap,
        fromLayer: Int,
        saveDecisions: ReadableArray,
        consentType: Int,
        promise: Promise
    )

    @ReactMethod
    abstract fun saveOptOutForCCPA(isOptedOut: Boolean, consentType: Int, promise: Promise)

    @ReactMethod
    abstract fun track(event: Int)

    companion object {
        const val NAME = "RNUsercentricsModule"
    }
}
