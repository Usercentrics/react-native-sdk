package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.WritableMap
import com.usercentrics.ccpa.CCPAData

internal fun CCPAData.serialize(): WritableMap {
    return mapOf(
        "uspString" to toUSPString(),
        "version" to version,
        "noticeGiven" to noticeGiven,
        "optedOut" to optedOut,
        "lspact" to lspact
    ).toWritableMap()
}