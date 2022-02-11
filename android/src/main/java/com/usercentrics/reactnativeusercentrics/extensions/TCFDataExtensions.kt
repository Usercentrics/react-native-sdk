package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.services.tcf.interfaces.*

internal fun TCFData.serialize(): WritableMap {
    return mapOf(
        "features" to features.map { it.serialize() },
        "purposes" to purposes.map { it.serialize() },
        "specialFeatures" to specialFeatures.map { it.serialize() },
        "specialPurposes" to specialPurposes.map { it.serialize() },
        "stacks" to stacks.map { it.serialize() },
        "vendors" to vendors.map { it.serialize() }
    ).toWritableMap()
}

private fun TCFFeature.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "descriptionLegal" to descriptionLegal,
        "id" to id,
        "name" to name,
    ).toWritableMap()
}

private fun TCFPurpose.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "descriptionLegal" to descriptionLegal,
        "id" to id,
        "name" to name,
        "consent" to consent,
        "isPartOfASelectedStack" to isPartOfASelectedStack,
        "legitimateInterestConsent" to legitimateInterestConsent,
        "showConsentToggle" to showConsentToggle,
        "showLegitimateInterestToggle" to showLegitimateInterestToggle,
        "stackId" to stackId,
    ).toWritableMap()
}


private fun TCFSpecialPurpose.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "descriptionLegal" to descriptionLegal,
        "id" to id,
        "name" to name,
    ).toWritableMap()
}

private fun TCFSpecialFeature.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "descriptionLegal" to descriptionLegal,
        "id" to id,
        "name" to name,
        "consent" to consent,
        "isPartOfASelectedStack" to isPartOfASelectedStack,
        "stackId" to stackId,
        "showConsentToggle" to showConsentToggle,
    ).toWritableMap()
}

private fun TCFStack.serialize(): WritableMap {
    return mapOf(
        "description" to description,
        "id" to id,
        "name" to name,
        "purposeIds" to purposeIds,
        "specialFeatureIds" to specialFeatureIds,
    ).toWritableMap()
}

private fun TCFVendor.serialize(): WritableMap {
    return mapOf(
        "consent" to consent,
        "features" to features.map { it.id },
        "flexiblePurposes" to flexiblePurposes.map { it.id },
        "id" to id,
        "legitimateInterestConsent" to legitimateInterestConsent,
        "legitimateInterestPurposes" to legitimateInterestPurposes.map { it.id },
        "name" to name,
        "policyUrl" to policyUrl,
        "purposes" to purposes.map { it.id },
//        "restrictions" to restrictions.map { restrictions.serialize() },
        "specialFeatures" to specialFeatures.map { it.id },
        "specialPurposes" to specialPurposes.map { it.id },
        "showConsentToggle" to showConsentToggle,
        "showLegitimateInterestToggle" to showLegitimateInterestToggle,
        "cookieMaxAgeSeconds" to cookieMaxAgeSeconds,
        "usesNonCookieAccess" to usesNonCookieAccess,
        "deviceStorageDisclosureUrl" to deviceStorageDisclosureUrl,
//        "deviceStorage" to deviceStorage.serialize(),
        "usesCookies" to usesCookies,
        "cookieRefresh" to cookieRefresh,
        "dataSharedOutsideEU" to dataSharedOutsideEU
    ).toWritableMap()
}
