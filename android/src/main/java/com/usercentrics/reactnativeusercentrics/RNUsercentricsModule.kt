package com.usercentrics.reactnativeusercentrics

import android.app.Activity
import android.content.Intent
import com.facebook.react.bridge.*
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxy
import com.usercentrics.reactnativeusercentrics.extensions.toWritableMap
import com.usercentrics.reactnativeusercentrics.extensions.usercentricsOptionsFromMap
import com.usercentrics.reactnativeusercentrics.extensions.usercentricsUISettingsFromMap
import com.usercentrics.sdk.UsercentricsActivityContract

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
        val usercentricsOptions = options.usercentricsOptionsFromMap() ?: return
        try {
            usercentricsProxy.initialize(reactApplicationContext, usercentricsOptions)
        } catch (e: Exception) {
            // Do nothing. it's already initialized and we're suffering from hot reload;
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
    fun reset() {
        usercentricsProxy.reset()
    }
}