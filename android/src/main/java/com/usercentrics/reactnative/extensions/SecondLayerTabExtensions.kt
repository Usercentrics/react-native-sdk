package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.ReadableType
import com.usercentrics.sdk.models.settings.SecondLayerTab

// The tab travels inside the options map. A missing, null, non-string or unknown value falls back
// to the default tab, like a tab the layout does not have.
internal fun ReadableMap?.secondLayerTab(): SecondLayerTab? {
    if (this == null || !hasKey("tab") || getType("tab") != ReadableType.String) {
        return null
    }
    val value = getString("tab") ?: return null
    return runCatching { SecondLayerTab.valueOf(value) }.getOrNull()
}
