package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.UsercentricsReadyStatus

internal fun UsercentricsReadyStatus.toWritableMap(): WritableMap {
    return Arguments.createMap().apply {
        putBoolean("shouldShowCMP", shouldShowCMP)
        putArray("consents", consents.toWritableArray())
    }
}