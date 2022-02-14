package com.usercentrics.reactnativeusercentrics.api

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.reactnativeusercentrics.extensions.bannerSettingsFromMap
import com.usercentrics.reactnativeusercentrics.extensions.firstLayerStyleSettingsFromMap
import com.usercentrics.reactnativeusercentrics.extensions.toWritableMap
import com.usercentrics.reactnativeusercentrics.extensions.usercentricsLayoutFromEnumString
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError
import java.lang.Exception

interface UsercentricsProxy {
    val instance: UsercentricsSDK

    fun initialize(context: Context, options: UsercentricsOptions)

    fun isReady(
        onSuccess: (UsercentricsReadyStatus) -> Unit,
        onFailure: (UsercentricsError) -> Unit
    )

    fun createIntent(
        context: Context,
        usercentricsOptions: UsercentricsUISettings
    ): Intent

    fun parseResult(resultCode: Int, data: Intent?): UsercentricsConsentUserResponse?

    fun showFirstLayer(
        activity: Activity,
        layout: UsercentricsLayout,
        bannerSettings: BannerSettings?,
        firstLayerStyleSettings: FirstLayerStyleSettings?,
        promise: Promise
    )

    fun showSecondLayer()

    fun reset()
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

    override fun createIntent(
        context: Context,
        usercentricsOptions: UsercentricsUISettings
    ): Intent {
        return UsercentricsActivityContract().createIntent(
            context,
            usercentricsOptions
        )
    }

    override fun parseResult(resultCode: Int, data: Intent?): UsercentricsConsentUserResponse? {
        return UsercentricsActivityContract()
            .parseResult(resultCode, data)
    }

    override fun showFirstLayer(
        activity: Activity,
        layout: UsercentricsLayout,
        bannerSettings: BannerSettings?,
        firstLayerStyleSettings: FirstLayerStyleSettings?,
        promise: Promise
    ) {
        UsercentricsBanner(activity, bannerSettings).showFirstLayer(
            layout,
            firstLayerStyleSettings
        ) {
            promise.resolve(it?.toWritableMap())
        }
    }

    override fun showSecondLayer() {

    }

    override fun reset() = Usercentrics.reset()

}