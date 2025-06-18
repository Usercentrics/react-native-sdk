package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.UsercentricsConsentHistoryEntry
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
        putBoolean("isEssential", isEssential)
        putArray("history", history.toWritableArray())
        putString("category", category)
    }
}

private fun List<UsercentricsConsentHistoryEntry>.toWritableArray(): ReadableArray? {
    map {
        Arguments.createMap().apply {
            putBoolean("status", it.status)
            putInt("type", it.type.ordinal)
            putInt("timestampInMillis", it.timestampInMillis.toInt())
        }
    }.apply {
        val array = Arguments.createArray()
        forEach {
            array.pushMap(it)
        }

        return array
    }
}

