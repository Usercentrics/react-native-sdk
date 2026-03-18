package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.services.gpp.GppData
import com.usercentrics.sdk.services.gpp.GppSectionChangePayload

private fun normalizeNumber(value: Double): Any {
    return if (value % 1.0 == 0.0 && value <= Int.MAX_VALUE && value >= Int.MIN_VALUE) {
        value.toInt()
    } else {
        value
    }
}

private fun Any?.toWritableValue(): Any? {
    return when (this) {
        null -> null
        is Boolean -> this
        is Number -> normalizeNumber(this.toDouble())
        is String -> this
        is Map<*, *> -> this.toWritableMap()
        is Iterable<*> -> this.toWritableArray()
        is Array<*> -> this.asList().toWritableArray()
        else -> this.toString()
    }
}

private fun Map<*, *>.toWritableMap(): WritableMap {
    val result = Arguments.createMap()
    for ((key, value) in this) {
        val fieldName = key?.toString() ?: continue
        when (val writableValue = value.toWritableValue()) {
            null -> result.putNull(fieldName)
            is Boolean -> result.putBoolean(fieldName, writableValue)
            is Int -> result.putInt(fieldName, writableValue)
            is Double -> result.putDouble(fieldName, writableValue)
            is String -> result.putString(fieldName, writableValue)
            is WritableMap -> result.putMap(fieldName, writableValue)
            is WritableArray -> result.putArray(fieldName, writableValue)
            else -> result.putString(fieldName, writableValue.toString())
        }
    }
    return result
}

private fun Iterable<*>.toWritableArray(): WritableArray {
    val result = Arguments.createArray()
    for (item in this) {
        when (val writableValue = item.toWritableValue()) {
            null -> result.pushNull()
            is Boolean -> result.pushBoolean(writableValue)
            is Int -> result.pushInt(writableValue)
            is Double -> result.pushDouble(writableValue)
            is String -> result.pushString(writableValue)
            is WritableMap -> result.pushMap(writableValue)
            is WritableArray -> result.pushArray(writableValue)
            else -> result.pushString(writableValue.toString())
        }
    }
    return result
}

internal fun GppData.serializeGppData(): WritableMap {
    val sectionsMap = Arguments.createMap()
    sections.forEach { (sectionName, fields) ->
        val fieldsMap = fields.toWritableMap()
        sectionsMap.putMap(sectionName, fieldsMap)
    }

    val result = Arguments.createMap()
    result.putString("gppString", gppString)
    result.putArray("applicableSections", applicableSections.serialize())
    result.putMap("sections", sectionsMap)
    return result
}

internal fun GppSectionChangePayload.serializeGppPayload(): WritableMap {
    val result = Arguments.createMap()
    result.putString("data", data)
    return result
}
