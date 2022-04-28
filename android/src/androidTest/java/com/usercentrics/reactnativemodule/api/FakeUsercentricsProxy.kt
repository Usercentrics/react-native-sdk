package com.usercentrics.reactnativemodule.api

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxy
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError

internal class FakeUsercentricsProxy(
    private val instanceAnswer: UsercentricsSDK? = null,
    private val isReadyAnswer: Any? = null
) : UsercentricsProxy {

    override val instance: UsercentricsSDK
        get() = instanceAnswer!!

    var initializeCount: Int = 0
        private set
    var initializeOptionsArgument: UsercentricsOptions? = null
        private set

    override fun initialize(context: Context, options: UsercentricsOptions) {
        initializeCount++
        initializeOptionsArgument = options
    }

    var isReadyCount: Int = 0
        private set

    override fun isReady(
        onSuccess: (UsercentricsReadyStatus) -> Unit,
        onFailure: (UsercentricsError) -> Unit
    ) {
        isReadyCount++
        if (isReadyAnswer is UsercentricsReadyStatus) {
            onSuccess(isReadyAnswer)
        } else if (isReadyAnswer is UsercentricsError) {
            onFailure(isReadyAnswer)
        }
    }

    var resetCount: Int = 0
        private set

    override fun reset() {
        resetCount++
    }

    var showFirstLayerLayout: UsercentricsLayout? = null
    var showFirstLayerBannerSettings: BannerSettings? = null
    var showFirstLayerStyle: FirstLayerStyleSettings? = null

    override fun showFirstLayer(activity: Activity, layout: UsercentricsLayout, bannerSettings: BannerSettings?, promise: Promise) {
        this.showFirstLayerLayout = layout
        this.showFirstLayerBannerSettings = bannerSettings
        this.showFirstLayerStyle = bannerSettings?.firstLayerSettings
    }

    override fun showSecondLayer(activity: Activity, bannerSettings: BannerSettings?, promise: Promise) {
    }
}
