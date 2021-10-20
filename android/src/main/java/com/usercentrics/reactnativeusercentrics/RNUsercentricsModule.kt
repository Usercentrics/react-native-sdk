package com.usercentrics.reactnativeusercentrics

import android.app.Activity
import android.content.Intent
import com.facebook.react.bridge.*
import com.usercentrics.reactnativeusercentrics.extensions.toWritableMap
import com.usercentrics.reactnativeusercentrics.extensions.usercentricsOptionsFromMap
import com.usercentrics.reactnativeusercentrics.extensions.usercentricsUISettingsFromMap
import com.usercentrics.sdk.Usercentrics
import com.usercentrics.sdk.UsercentricsActivityContract

internal class RNUsercentricsModule(reactContext: ReactApplicationContext) :
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
            if (requestCode != showCMPRequestCode) return
            assert(pendingPromise != null)

            val response = UsercentricsActivityContract()
                .parseResult(resultCode, data)
                ?.toWritableMap()

            pendingPromise?.resolve(response)
            pendingPromise = null

            return
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
            Usercentrics.initialize(reactApplicationContext, usercentricsOptions)
        } catch (e: Exception) {
            // Do nothing. it's already initialized and we're suffering from hot reload;
        }
    }

    @ReactMethod
    fun isReady(promise: Promise) {
        Usercentrics.isReady({
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    fun showCMP(options: ReadableMap, promise: Promise) {
        val usercentricsOptions = options.usercentricsUISettingsFromMap(currentActivity!!.assets)
        this.pendingPromise = promise

        val intent = UsercentricsActivityContract().createIntent(
            reactApplicationContext,
            usercentricsOptions
        )

        currentActivity?.startActivityForResult(intent, showCMPRequestCode)
    }

    @ReactMethod
    fun restoreUserSession(controllerId: String, promise: Promise) {
        Usercentrics.instance.restoreUserSession(controllerId, {
            promise.resolve(it.toWritableMap())
        }, {
            promise.reject(it)
        })
    }

    @ReactMethod
    fun getTCFString(promise: Promise) {
        promise.resolve(Usercentrics.instance.getTCString())
    }

    @ReactMethod
    fun getControllerId(promise: Promise) {
        promise.resolve(Usercentrics.instance.getControllerId())
    }

    @ReactMethod
    fun reset() {
        Usercentrics.reset()
    }
}