package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.UsercentricsConsentUserResponse

internal fun UsercentricsConsentUserResponse.toWritableMap(): WritableMap {
    return Arguments.createMap().apply {
        putString("controllerId", controllerId)
        putInt("userInteraction", userInteraction.ordinal)
        putArray("consents", consents.toWritableArray())
    }
}