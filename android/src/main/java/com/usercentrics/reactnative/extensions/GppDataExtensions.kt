package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.services.gpp.GppData
import com.usercentrics.sdk.services.gpp.GppSectionChangePayload

internal fun GppData.serializeGppData(): WritableMap {
    val sectionsMap = Arguments.createMap()
    sections.forEach { (sectionName, fields) ->
        val fieldsMap = Arguments.createMap()
        fields.forEach { (fieldName, value) ->
            when (value) {
                null -> fieldsMap.putNull(fieldName)
                is Boolean -> fieldsMap.putBoolean(fieldName, value)
                is Int -> fieldsMap.putInt(fieldName, value)
                is Double -> fieldsMap.putDouble(fieldName, value)
                is String -> fieldsMap.putString(fieldName, value)
                else -> fieldsMap.putString(fieldName, value.toString())
            }
        }
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
