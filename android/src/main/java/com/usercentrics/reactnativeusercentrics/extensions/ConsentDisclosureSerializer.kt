package com.usercentrics.reactnativeusercentrics.extensions

import com.usercentrics.sdk.v2.settings.data.ConsentDisclosure
import com.usercentrics.sdk.v2.settings.data.ConsentDisclosureObject

internal fun ConsentDisclosureObject?.serialize(): Any? {
    if (this == null) {
        return null
    }
    return disclosures.map { it.serialize() }
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
