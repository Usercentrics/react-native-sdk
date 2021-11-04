package com.usercentrics.reactnativemodule.api

import android.content.Context
import android.content.Intent
import com.usercentrics.reactnativeusercentrics.api.UsercentricsProxy
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError
import com.usercentrics.sdk.models.settings.UsercentricsConsent

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

    var createIntentValue: Intent? = null
    var usercentricsOptions: UsercentricsUISettings? = null
        private set

    override fun createIntent(
        context: Context,
        usercentricsOptions: UsercentricsUISettings
    ): Intent {
        this.usercentricsOptions = usercentricsOptions
        return createIntentValue!!
    }

    var parseResultResultCodeArgument: Int = 0
        private set
    var parseResultValue: UsercentricsConsentUserResponse? = null
    override fun parseResult(resultCode: Int, data: Intent?): UsercentricsConsentUserResponse? {
        this.parseResultResultCodeArgument = resultCode
        return parseResultValue
    }

    var resetCount: Int = 0
        private set

    override fun reset() {
        resetCount++
    }
}