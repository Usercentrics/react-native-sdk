package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
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

internal fun List<*>.serialize(): WritableArray {
    val array = Arguments.createArray()
    forEach { value ->
        when (value) {
            is Boolean -> {
                array.pushBoolean(value)
            }
            is Int -> {
                array.pushInt(value)
            }
            is Double -> {
                array.pushDouble(value)
            }
            is String -> {
                array.pushString(value)
            }
            is Map<*, *> -> {
                val newMap = (value as Map<String, Any>).toWritableMap()
                array.pushMap(newMap)
            }

            is List<*> -> {
                val newArray = value.serialize()
                array.pushArray(newArray)
            }

            is WritableMap -> {
                array.pushMap(value)
            }

            is WritableArray -> {
                array.pushArray(value)
            }
        }
    }
    return array
}

internal fun Map<String, Any?>.toWritableMap(): WritableMap {
    val map = Arguments.createMap()

    forEach { (key, value) ->
        when (value) {
            is Boolean -> {
                map.putBoolean(key, value)
            }
            is Int -> {
                map.putInt(key, value)
            }
            is Double -> {
                map.putDouble(key, value)
            }
            is String -> {
                map.putString(key, value)
            }
            is Map<*, *> -> {
                val newMap = (value as Map<String, Any>).toWritableMap()
                map.putMap(key, newMap)
            }

            is WritableMap -> {
                map.putMap(key, value)
            }

            is WritableArray -> {
                map.putArray(key, value)
            }

            is List<*> -> {
                map.putArray(key, value.serialize())
            }

        }
    }

    return map
}
