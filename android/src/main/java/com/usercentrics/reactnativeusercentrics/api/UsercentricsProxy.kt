package com.usercentrics.reactnativeusercentrics.api

import android.content.Context
import android.content.Intent
import android.util.Log
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError

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

    fun reset()
}

internal class UsercentricsProxyImpl : UsercentricsProxy {

    override val instance: UsercentricsSDK
        get() = Usercentrics.instance

    override fun initialize(context: Context, options: UsercentricsOptions) {
        Usercentrics.initialize(context, options)
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

    override fun reset() = Usercentrics.reset()

}