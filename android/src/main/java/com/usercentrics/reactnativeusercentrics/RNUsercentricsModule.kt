package com.usercentrics.reactnativeusercentrics

import com.facebook.react.bridge.*
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxy
import com.usercentrics.reactnativeusercentrics.extensions.*
import com.usercentrics.sdk.UsercentricsAnalyticsEventType
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import com.usercentrics.sdk.services.tcf.TCFDecisionUILayer

internal class RNUsercentricsModule(
    reactContext: ReactApplicationContext,
    private val usercentricsProxy: UsercentricsProxy,
    private val reactContextProvider: ReactContextProvider,
) : ReactContextBaseJavaModule(reactContext) {

    override fun getName() = "RNUsercentricsModule"

    @ReactMethod
    fun configure(options: ReadableMap) {
        val usercentricsOptions = options.usercentricsOptionsFromMap()
        usercentricsProxy.initialize(reactApplicationContext, usercentricsOptions)
    }

    @ReactMethod
    fun isReady(promise: Promise) {
        usercentricsProxy.isReady({
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    fun showFirstLayer(options: ReadableMap?, promise: Promise) {
        runOnUiThread {
            try {
                val context = reactContextProvider.context()
                val bannerSettings = options?.bannerSettingsFromMap(context)

                val activity = reactContextProvider.activity()!!
                usercentricsProxy.showFirstLayer(activity, bannerSettings, promise)
            } catch (e: Exception) {
                promise.reject(e)
            }
        }
    }

    @ReactMethod
    fun showSecondLayer(options: ReadableMap, promise: Promise) {
        runOnUiThread {
            try {
                val context = reactContextProvider.context()
                val bannerSettings = options.bannerSettingsFromMap(context)

                val activity = reactContextProvider.activity()!!
                usercentricsProxy.showSecondLayer(activity, bannerSettings, promise)
            } catch (e: Exception) {
                promise.reject(e)
            }
        }
    }

    @ReactMethod
    fun restoreUserSession(controllerId: String, promise: Promise) {
        usercentricsProxy.instance.restoreUserSession(controllerId, {
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    fun getControllerId(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getControllerId())
    }

    @ReactMethod
    fun getABTestingVariant(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getABTestingVariant())
    }

    @ReactMethod
    fun getConsents(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getConsents().toWritableArray())
    }

    @ReactMethod
    fun getCMPData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getCMPData().serialize())
    }

    @ReactMethod
    fun getAdditionalConsentModeData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getAdditionalConsentModeData().serialize())
    }

    @ReactMethod
    fun setCMPId(id: Int) {
        usercentricsProxy.instance.setCMPId(id)
    }

    @ReactMethod
    fun setABTestingVariant(variant: String) {
        usercentricsProxy.instance.setABTestingVariant(variant)
    }

    @ReactMethod
    fun getTCFData(promise: Promise) {
        usercentricsProxy.instance.getTCFData {
            promise.resolve(it.serialize())
        }
    }

    @ReactMethod
    fun getUserSessionData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getUserSessionData())
    }

    @ReactMethod
    fun getUSPData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getUSPData().serialize())
    }

    @ReactMethod
    fun changeLanguage(language: String, promise: Promise) {
        usercentricsProxy.instance.changeLanguage(language, {
            promise.resolve(null)
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    fun acceptAllForTCF(fromLayer: Int, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAllForTCF(
                TCFDecisionUILayer.values()[fromLayer], UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun acceptAll(consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAll(
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun denyAllForTCF(fromLayer: Int, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAllForTCF(
                TCFDecisionUILayer.values()[fromLayer], UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun denyAll(consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAll(
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun saveDecisionsForTCF(
        tcfDecisions: ReadableMap,
        fromLayer: Int,
        saveDecisions: ReadableArray,
        consentType: Int,
        promise: Promise
    ) {
        promise.resolve(
            usercentricsProxy.instance.saveDecisionsForTCF(
                tcfDecisions.deserializeTCFUserDecisions(),
                TCFDecisionUILayer.values()[fromLayer],
                saveDecisions.deserializeUserDecision(),
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun saveDecisions(decisions: ReadableArray, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveDecisions(
                decisions.deserializeUserDecision(), UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun saveOptOutForCCPA(isOptedOut: Boolean, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveOptOutForCCPA(
                isOptedOut, UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun track(event: Int) {
        usercentricsProxy.instance.track(UsercentricsAnalyticsEventType.values()[event])
    }

    @ReactMethod
    fun reset() {
        usercentricsProxy.reset()
    }

    private fun runOnUiThread(block: () -> Unit) {
        UiThreadUtil.runOnUiThread(block)
    }
}
