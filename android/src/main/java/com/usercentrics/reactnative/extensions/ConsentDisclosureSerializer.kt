package com.usercentrics.reactnative.extensions

import com.usercentrics.sdk.v2.settings.data.ConsentDisclosure
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosureObject
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosureSDK

internal fun ConsentDisclosureObject?.serialize(): Any? {
    if (this == null) {
        return null
    }
    return mapOf(
        "disclosures" to disclosures.map { it.serialize() },
        "sdks" to sdks.map { it.serialize() }
    )
}

private fun ConsentDisclosureSDK.serialize(): Map<String, Any> {
    return mapOf(
        "name" to name,
        "use" to use
    )
}

internal fun ConsentDisclosure.serialize(): Any {
    return mapOf(
        "identifier" to identifier,
        "type" to type?.ordinal,
        "name" to name,
        "maxAgeSeconds" to maxAgeSeconds,
        "cookieRefresh" to cookieRefresh,
        "purposes" to purposes,
        "domain" to domain,
        "description" to description,
    )
}
