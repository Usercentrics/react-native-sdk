package com.usercentrics.reactnative

import android.app.Activity
import android.content.Context
import com.facebook.react.bridge.ReactApplicationContext

internal class ReactContextProviderImpl(
    private val reactContext: ReactApplicationContext
) : ReactContextProvider {

    override fun context(): Context {
        return reactContext
    }

    override fun activity(): Activity? {
        return reactContext.currentActivity
    }
}
