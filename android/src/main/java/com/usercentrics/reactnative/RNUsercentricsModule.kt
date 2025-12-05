package com.usercentrics.reactnative

import com.facebook.react.bridge.*
import com.usercentrics.reactnative.api.UsercentricsProxy
import com.usercentrics.reactnative.extensions.*
import com.usercentrics.sdk.UsercentricsAnalyticsEventType
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import com.usercentrics.sdk.services.tcf.TCFDecisionUILayer

internal class RNUsercentricsModule(
    reactContext: ReactApplicationContext,
    private val usercentricsProxy: UsercentricsProxy,
    private val reactContextProvider: ReactContextProvider,
) : RNUsercentricsModuleSpec(reactContext) {

    override fun getName() = NAME

    @ReactMethod
    override fun configure(options: ReadableMap) {
        val usercentricsOptions = options.usercentricsOptionsFromMap()
        usercentricsProxy.initialize(reactApplicationContext, usercentricsOptions)
    }

    @ReactMethod
    override fun isReady(promise: Promise) {
        usercentricsProxy.isReady({
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    override fun showFirstLayer(options: ReadableMap?, promise: Promise) {
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
    override fun showSecondLayer(options: ReadableMap?, promise: Promise) {
        runOnUiThread {
            try {
                val context = reactContextProvider.context()
                val bannerSettings = options?.bannerSettingsFromMap(context)

                val activity = reactContextProvider.activity()!!
                usercentricsProxy.showSecondLayer(activity, bannerSettings, promise)
            } catch (e: Exception) {
                promise.reject(e)
            }
        }
    }

    @ReactMethod
    override fun restoreUserSession(controllerId: String, promise: Promise) {
        usercentricsProxy.instance.restoreUserSession(controllerId, {
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    override fun getControllerId(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getControllerId())
    }

    @ReactMethod
    override fun getABTestingVariant(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getABTestingVariant())
    }

    @ReactMethod
    override fun getConsents(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getConsents().toWritableArray())
    }

    @ReactMethod
    override fun getCMPData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getCMPData().serialize())
    }

    @ReactMethod
    override fun getAdditionalConsentModeData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getAdditionalConsentModeData().serialize())
    }

    @ReactMethod
    override fun setCMPId(id: Int) {
        usercentricsProxy.instance.setCMPId(id)
    }

    @ReactMethod
    override fun setABTestingVariant(variant: String) {
        usercentricsProxy.instance.setABTestingVariant(variant)
    }

    @ReactMethod
    override fun getTCFData(promise: Promise) {
        usercentricsProxy.instance.getTCFData {
            promise.resolve(it.serialize())
        }
    }

    @ReactMethod
    override fun getUserSessionData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getUserSessionData())
    }

    @ReactMethod
    override fun getUSPData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getUSPData().serialize())
    }

    @ReactMethod
    override fun changeLanguage(language: String, promise: Promise) {
        usercentricsProxy.instance.changeLanguage(language, {
            promise.resolve(null)
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    override fun acceptAllForTCF(fromLayer: Int, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAllForTCF(
                TCFDecisionUILayer.values()[fromLayer], UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun acceptAll(consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAll(
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun denyAllForTCF(fromLayer: Int, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAllForTCF(
                TCFDecisionUILayer.values()[fromLayer], UsercentricsConsentType.values()[consentType], emptyList()
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun denyAll(consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAll(
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun saveDecisionsForTCF(
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
    override fun saveDecisions(decisions: ReadableArray, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveDecisions(
                decisions.deserializeUserDecision(), UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun saveOptOutForCCPA(isOptedOut: Boolean, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveOptOutForCCPA(
                isOptedOut, UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun track(event: Int) {
        usercentricsProxy.instance.track(UsercentricsAnalyticsEventType.values()[event])
    }

    @ReactMethod
    override fun clearUserSession(promise: Promise) {
        usercentricsProxy.instance.clearUserSession({
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    private fun runOnUiThread(block: () -> Unit) {
        UiThreadUtil.runOnUiThread(block)
    }

    companion object {
        const val NAME = "RNUsercentricsModule"
    }
}
