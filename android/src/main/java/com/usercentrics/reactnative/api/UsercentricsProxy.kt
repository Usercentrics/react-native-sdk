package com.usercentrics.reactnative.api

import android.app.Activity
import android.content.Context
import com.facebook.react.bridge.Promise
import com.usercentrics.reactnative.extensions.toWritableMap
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError

interface UsercentricsProxy {

    val instance: UsercentricsSDK

    fun initialize(context: Context, options: UsercentricsOptions)
    fun isReady(onSuccess: (UsercentricsReadyStatus) -> Unit, onFailure: (UsercentricsError) -> Unit)

    fun showFirstLayer(activity: Activity, bannerSettings: BannerSettings?, promise: Promise)
    fun showSecondLayer(activity: Activity, bannerSettings: BannerSettings?, promise: Promise)
}

internal class UsercentricsProxyImpl : UsercentricsProxy {

    override val instance: UsercentricsSDK
        get() = Usercentrics.instance

    override fun initialize(context: Context, options: UsercentricsOptions) {
        try {
            Usercentrics.initialize(context, options)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun isReady(
        onSuccess: (UsercentricsReadyStatus) -> Unit,
        onFailure: (UsercentricsError) -> Unit
    ) = Usercentrics.isReady(onSuccess, onFailure)

    override fun showFirstLayer(
        activity: Activity,
        bannerSettings: BannerSettings?,
        promise: Promise,
    ) {
        UsercentricsBanner(activity, bannerSettings).showFirstLayer {
            promise.resolve(it?.toWritableMap())
        }
    }

    override fun showSecondLayer(
        activity: Activity,
        bannerSettings: BannerSettings?,
        promise: Promise,
    ) {
        UsercentricsBanner(activity, bannerSettings).showSecondLayer {
            promise.resolve(it?.toWritableMap())
        }
    }
}
