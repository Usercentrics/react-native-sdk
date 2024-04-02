package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.GeolocationRuleset
import com.usercentrics.sdk.UsercentricsReadyStatus

internal fun UsercentricsReadyStatus.toWritableMap(): WritableMap {
    return Arguments.createMap().apply {
        putBoolean("shouldCollectConsent", shouldCollectConsent)
        putArray("consents", consents.toWritableArray())
        putMap("geolocationRuleset", geolocationRuleset?.serialize())
        putMap("location", location.serialize())
    }
}

internal fun GeolocationRuleset.serialize(): WritableMap {
    return mapOf(
        "activeSettingsId" to activeSettingsId,
        "bannerRequiredAtLocation" to bannerRequiredAtLocation,
    ).toWritableMap()
}
