package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.UsercentricsOptions
import com.usercentrics.sdk.models.common.UsercentricsLoggerLevel

internal fun ReadableMap.usercentricsOptionsFromMap(): UsercentricsOptions? {
    return getString("settingsId")?.let { settingsId ->
        val usercentricsOptions = UsercentricsOptions(settingsId)

        getIntOrNull("loggerLevel")?.let {
            usercentricsOptions.loggerLevel = when (it) {
                0 -> UsercentricsLoggerLevel.NONE
                1 -> UsercentricsLoggerLevel.ERROR
                2 -> UsercentricsLoggerLevel.WARNING
                else -> UsercentricsLoggerLevel.DEBUG
            }
        }

        getDoubleOrNull("timeoutMillis")?.let {
            usercentricsOptions.timeoutMillis = it.toLong()
        }

        getString("version")?.let {
            usercentricsOptions.version = it
        }

        getString("defaultLanguage")?.let {
            usercentricsOptions.defaultLanguage = it
        }

        usercentricsOptions
    }
}