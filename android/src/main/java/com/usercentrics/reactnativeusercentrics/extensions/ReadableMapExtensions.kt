package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.UsercentricsOptions
import com.usercentrics.sdk.models.common.UsercentricsLoggerLevel

internal fun ReadableMap.getIntOrNull(key: String): Int? {
    return if (hasKey(key) && !isNull(key)) {
        return getInt(key)
    } else {
        null
    }
}

internal fun ReadableMap.getDoubleOrNull(key: String): Double? {
    return if (hasKey(key) && !isNull(key)) {
        return getDouble(key)
    } else {
        null
    }
}

internal fun ReadableMap.getBooleanOrNull(key: String): Boolean? {
    return if (hasKey(key) && !isNull(key)) {
        return getBoolean(key)
    } else {
        null
    }
}
