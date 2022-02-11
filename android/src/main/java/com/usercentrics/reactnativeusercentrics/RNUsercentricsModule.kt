package com.usercentrics.reactnativeusercentrics

import android.app.Activity
import android.content.Intent
import com.facebook.react.bridge.*
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxy
import com.usercentrics.reactnativeusercentrics.extensions.*
import com.usercentrics.sdk.UsercentricsBanner
import com.usercentrics.sdk.UsercentricsLayout
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import com.usercentrics.sdk.services.tcf.TCFDecisionUILayer
import java.lang.Exception

internal class RNUsercentricsModule(
    reactContext: ReactApplicationContext,
    private val usercentricsProxy: UsercentricsProxy
) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName() = "RNUsercentricsModule"

    private var pendingPromise: Promise? = null
    private val listener: ActivityEventListener = object : BaseActivityEventListener() {
        override fun onActivityResult(
            activity: Activity?,
            requestCode: Int,
            resultCode: Int,
            data: Intent?
        ) {
            parseActivityResult(requestCode, resultCode, data)
        }
    }

    init {
        reactApplicationContext.addActivityEventListener(listener)
    }

    companion object {
        private const val showCMPRequestCode = 81420
    }

    @ReactMethod
    fun configure(options: ReadableMap) {
        var alreadyConfigured = false
        usercentricsProxy.isReady({
            alreadyConfigured = true
        }, {
            alreadyConfigured = true
        })

        if (!alreadyConfigured) {
            val usercentricsOptions = options.usercentricsOptionsFromMap() ?: return
            usercentricsProxy.initialize(reactApplicationContext, usercentricsOptions)
        }
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
    fun showCMP(options: ReadableMap, promise: Promise) {
        val usercentricsOptions = options.usercentricsUISettingsFromMap(currentActivity!!.assets)
        this.pendingPromise = promise

        val intent = usercentricsProxy.createIntent(reactApplicationContext, usercentricsOptions)
        currentActivity?.startActivityForResult(intent, showCMPRequestCode)
    }

    @ReactMethod
    fun showFirstLayer(options: ReadableMap, promise: Promise) {
        try {
            val assetManager = currentActivity!!.assets
            val layout = options.getString("layout")!!.usercentricsLayoutFromEnumString()
            val bannerSettings =
                options.getMap("bannerSettings")?.bannerSettingsFromMap(assetManager)
            val styleSettings =
                options.getMap("styleSettings")?.firstLayerStyleSettingsFromMap(assetManager)

            UsercentricsBanner(currentActivity!!, bannerSettings).showFirstLayer(
                layout,
                styleSettings
            ) {
                promise.resolve(it?.toWritableMap())
            }
        } catch (ex: Exception) {
            promise.reject(ex)
        }
    }

    @ReactMethod
    fun showSecondLayer(options: ReadableMap, promise: Promise) {
        try {
            val assetManager = currentActivity!!.assets

            val bannerSettings =
                options.getMap("bannerSettings")?.bannerSettingsFromMap(assetManager)
            val showCloseButton = options.getBoolean("showCloseButton")

            UsercentricsBanner(currentActivity!!, bannerSettings).showSecondLayer(
                showCloseButton
            ) {
                promise.resolve(it?.toWritableMap())
            }
        } catch (e: Exception) {
            promise.reject(e)
        }
    }

    internal fun parseActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != showCMPRequestCode) return false
        assert(pendingPromise != null)

        val response = usercentricsProxy.parseResult(resultCode, data)?.toWritableMap()

        pendingPromise?.resolve(response)
        pendingPromise = null

        return true
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
    fun getTCFString(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getTCString())
    }

    @ReactMethod
    fun getControllerId(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getControllerId())
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
    fun setCMPId(id: Int) {
        usercentricsProxy.instance.setCMPId(id)
    }

    @ReactMethod
    fun getTCFData(promise: Promise) {
        promise.resolve(usercentricsProxy.instance.getTCFData().serialize())
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
                TCFDecisionUILayer.values()[fromLayer],
                UsercentricsConsentType.values()[consentType]
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
                TCFDecisionUILayer.values()[fromLayer],
                UsercentricsConsentType.values()[consentType]
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
                decisions.deserializeUserDecision(),
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun saveOptOutForCCPA(isOptedOut: Boolean, consentType: Int, promise: Promise) {
        promise.resolve(
            usercentricsProxy.instance.saveOptOutForCCPA(
                isOptedOut,
                UsercentricsConsentType.values()[consentType]
            ).toWritableArray()
        )
    }

    @ReactMethod
    fun reset() {
        usercentricsProxy.reset()
    }
}