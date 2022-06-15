package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.UsercentricsOptions
import com.usercentrics.sdk.models.common.NetworkMode
import com.usercentrics.sdk.models.common.UsercentricsLoggerLevel

internal fun ReadableMap.usercentricsOptionsFromMap(): UsercentricsOptions? {
    val options = UsercentricsOptions()

    getString("settingsId")?.let {
        options.settingsId = it
    }

    getString("ruleSetId")?.let {
        options.ruleSetId = it
    }

    getIntOrNull("loggerLevel")?.let {
        options.loggerLevel = when (it) {
            0 -> UsercentricsLoggerLevel.NONE
            1 -> UsercentricsLoggerLevel.ERROR
            2 -> UsercentricsLoggerLevel.WARNING
            else -> UsercentricsLoggerLevel.DEBUG
        }
    }

    getDoubleOrNull("timeoutMillis")?.let {
        options.timeoutMillis = it.toLong()
    }

    getString("version")?.let {
        options.version = it
    }

    getString("defaultLanguage")?.let {
        options.defaultLanguage = it
    }

    getIntOrNull("networkMode")?.let {
        options.networkMode = when (it) {
            0 -> NetworkMode.WORLD
            1 -> NetworkMode.EU
            else -> {
                assert(false)
                NetworkMode.WORLD
            }
        }
    }

    return options
}