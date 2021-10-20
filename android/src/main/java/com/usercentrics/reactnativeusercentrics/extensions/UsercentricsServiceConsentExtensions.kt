package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.UsercentricsServiceConsent

internal fun List<UsercentricsServiceConsent>.toWritableArray(): WritableArray {
    map {
        it.toWritableMap()
    }.apply {
        val array = Arguments.createArray()

        forEach {
            array.pushMap(it)
        }

        return array
    }
}

internal fun UsercentricsServiceConsent.toWritableMap(): WritableMap {
    return Arguments.createMap().apply {
        putString("templateId", templateId)
        putBoolean("status", status)
        type?.let {
            putInt("type", it.ordinal)
        }
        putString("version", version)
        putString("dataProcessor", dataProcessor)
    }
}

