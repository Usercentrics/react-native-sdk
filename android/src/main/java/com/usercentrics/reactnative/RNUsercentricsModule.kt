package com.usercentrics.reactnative

import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.usercentrics.sdk.UsercentricsDisposableEvent
import com.usercentrics.sdk.UsercentricsEvent
import com.usercentrics.reactnative.api.UsercentricsProxy
import com.usercentrics.reactnative.extensions.*
import com.usercentrics.sdk.UsercentricsAnalyticsEventType
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import com.usercentrics.sdk.services.gpp.GppSectionChangePayload
import com.usercentrics.sdk.services.tcf.TCFDecisionUILayer

internal class RNUsercentricsModule(
    reactContext: ReactApplicationContext,
    private val usercentricsProxy: UsercentricsProxy,
    private val reactContextProvider: ReactContextProvider,
) : RNUsercentricsModuleSpec(reactContext) {
    private var gppSectionChangeSubscription: UsercentricsDisposableEvent<GppSectionChangePayload>? = null
    private var gppSectionChangeListenersCount = 0

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
    override fun setCMPId(id: Double) {
        usercentricsProxy.instance.setCMPId(id.toInt())
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
    override fun getGPPData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getGPPData().serializeGppData())
    }

    @ReactMethod
    override fun getGPPString(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getGPPString())
    }

    @ReactMethod
    override fun setGPPConsent(sectionName: String, fieldName: String, value: ReadableMap) {
        if (!value.hasKey("value")) return
        val parsedValue = if (value.getType("value") == ReadableType.Null) {
            null
        } else {
            readableMapValueToAny(value)
        }
        usercentricsProxy.instance.setGPPConsent(sectionName, fieldName, parsedValue)
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
    override fun acceptAllForTCF(fromLayer: Double, consentType: Double, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAllForTCF(
                TCFDecisionUILayer.values()[fromLayer.toInt()], UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun acceptAll(consentType: Double, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.acceptAll(
                UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun denyAllForTCF(fromLayer: Double, consentType: Double, unsavedPurposeLIDecisions: ReadableArray, unsavedVendorLIDecisions: ReadableArray, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAllForTCF(
                TCFDecisionUILayer.values()[fromLayer.toInt()], UsercentricsConsentType.values()[consentType.toInt()], unsavedPurposeLIDecisions.deserializePurposeLIDecisionsMap(), unsavedVendorLIDecisions.deserializePurposeLIDecisionsMap()
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun denyAll(consentType: Double, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.denyAll(
                UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun saveDecisionsForTCF(
        tcfDecisions: ReadableMap,
        fromLayer: Double,
        saveDecisions: ReadableArray,
        consentType: Double,
        promise: Promise
    ) {
        promise.resolve(
            usercentricsProxy.instance.saveDecisionsForTCF(
                tcfDecisions.deserializeTCFUserDecisions(),
                TCFDecisionUILayer.values()[fromLayer.toInt()],
                saveDecisions.deserializeUserDecision(),
                UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun saveDecisions(decisions: ReadableArray, consentType: Double, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveDecisions(
                decisions.deserializeUserDecision(), UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun saveOptOutForCCPA(isOptedOut: Boolean, consentType: Double, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveOptOutForCCPA(
                isOptedOut, UsercentricsConsentType.values()[consentType.toInt()]
            ).toWritableArray()
        )
    }

    @ReactMethod
    override fun track(event: Double) {
        usercentricsProxy.instance.track(UsercentricsAnalyticsEventType.values()[event.toInt()])
    }

    @ReactMethod
    override fun clearUserSession(promise: Promise) {
        usercentricsProxy.instance.clearUserSession({
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    override fun addListener(eventName: String) {
        if (eventName != ON_GPP_SECTION_CHANGE_EVENT) return

        gppSectionChangeListenersCount++
        if (gppSectionChangeSubscription != null) return

        gppSectionChangeSubscription = UsercentricsEvent.onGppSectionChange { payload ->
            emitEvent(ON_GPP_SECTION_CHANGE_EVENT, payload.serializeGppPayload())
        }
    }

    @ReactMethod
    override fun removeListeners(count: Double) {
        gppSectionChangeListenersCount = (gppSectionChangeListenersCount - count.toInt()).coerceAtLeast(0)
        if (gppSectionChangeListenersCount == 0) {
            gppSectionChangeSubscription?.dispose()
            gppSectionChangeSubscription = null
        }
    }

    override fun invalidate() {
        gppSectionChangeSubscription?.dispose()
        gppSectionChangeSubscription = null
        gppSectionChangeListenersCount = 0
        super.invalidate()
    }

    private fun emitEvent(eventName: String, payload: WritableMap) {
        reactApplicationContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit(eventName, payload)
    }

    private fun readableMapValueToAny(map: ReadableMap): Any? {
        if (!map.hasKey("value")) return null
        return when (map.getType("value")) {
            ReadableType.Null -> null
            ReadableType.Boolean -> map.getBoolean("value")
            ReadableType.Number -> normalizeNumber(map.getDouble("value"))
            ReadableType.String -> map.getString("value")
            ReadableType.Map -> normalizeCompositeValue(map.getMap("value")?.toHashMap())
            ReadableType.Array -> normalizeCompositeValue(map.getArray("value")?.toArrayList())
        }
    }

    private fun normalizeCompositeValue(value: Any?): Any? {
        return when (value) {
            is Double -> normalizeNumber(value)
            is ArrayList<*> -> value.map { normalizeCompositeValue(it) }
            is HashMap<*, *> -> value.entries.associate { (key, nestedValue) ->
                key.toString() to normalizeCompositeValue(nestedValue)
            }
            else -> value
        }
    }

    private fun normalizeNumber(value: Double): Any {
        return if (value % 1.0 == 0.0) value.toInt() else value
    }

    private fun runOnUiThread(block: () -> Unit) {
        UiThreadUtil.runOnUiThread(block)
    }

    companion object {
        const val NAME = "RNUsercentricsModule"
        const val ON_GPP_SECTION_CHANGE_EVENT = "onGppSectionChange"
    }
}
