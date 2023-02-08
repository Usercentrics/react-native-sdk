package com.usercentrics.reactnativemodule.mock

import android.app.Activity
import android.content.Context
import com.facebook.react.bridge.ReactApplicationContext
import com.usercentrics.reactnativeusercentrics.ReactContextProvider
import io.mockk.mockk

internal open class ReactContextProviderMock : ReactContextProvider {

    private val reactApplicationContext = mockk<ReactApplicationContext>(relaxed = true)

    override fun context(): Context {
        return reactApplicationContext
    }

    override fun activity(): Activity? {
        return reactApplicationContext.currentActivity
    }
}
