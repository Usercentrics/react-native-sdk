package com.usercentrics.reactnativeusercentrics

import android.app.Activity
import android.content.Context

internal interface ReactContextProvider {

    fun context(): Context
    fun activity(): Activity?
}
