package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.services.tcf.interfaces.TCFData
import com.usercentrics.sdk.services.tcf.interfaces.TCFFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFSpecialFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFSpecialPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFStack
import com.usercentrics.sdk.services.tcf.interfaces.TCFVendor
import com.usercentrics.sdk.services.tcf.interfaces.TCFVendorRestriction
import com.usercentrics.tcf.core.model.gvl.VendorUrl

internal fun TCFData.serialize(): WritableMap {
    return mapOf(
        "features" to features.map { it.serialize() },
        "purposes" to purposes.map { it.serialize() },
        "specialFeatures" to specialFeatures.map { it.serialize() },
        "specialPurposes" to specialPurposes.map { it.serialize() },
        "stacks" to stacks.map { it.serialize() },
        "vendors" to vendors.map { it.serialize() },
        "tcString" to tcString,
        "thirdPartyCount" to thirdPartyCount
    ).toWritableMap()
}

private fun TCFFeature.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "illustrations" to illustrations,
        "id" to id,
        "name" to name,
    ).toWritableMap()
}

private fun TCFPurpose.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "illustrations" to illustrations,
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
        "illustrations" to illustrations,
        "id" to id,
        "name" to name,
    ).toWritableMap()
}

private fun TCFSpecialFeature.serialize(): WritableMap {
    return mapOf(
        "purposeDescription" to purposeDescription,
        "illustrations" to illustrations,
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
        "specialFeatures" to specialFeatures.map { it.id },
        "specialPurposes" to specialPurposes.map { it.id },
        "showConsentToggle" to showConsentToggle,
        "showLegitimateInterestToggle" to showLegitimateInterestToggle,
        "cookieMaxAgeSeconds" to cookieMaxAgeSeconds,
        "usesNonCookieAccess" to usesNonCookieAccess,
        "deviceStorageDisclosureUrl" to deviceStorageDisclosureUrl,
        "usesCookies" to usesCookies,
        "cookieRefresh" to cookieRefresh,
        "dataSharedOutsideEU" to dataSharedOutsideEU,
        "dataCategories" to dataCategories.map { it.id },
        "vendorUrls" to vendorUrls.map { it.serialize() },
        "deviceStorage" to deviceStorage.serialize(),
        "restrictions" to restrictions.map { it.serialize() }
    ).toWritableMap()
}

private fun VendorUrl.serialize(): WritableMap {
    return mapOf(
        "langId" to langId,
        "privacy" to privacy,
        "legIntClaim" to legIntClaim
    ).toWritableMap()
}

private fun TCFVendorRestriction.serialize(): WritableMap {
    return mapOf(
        "purposeId" to purposeId,
        "restrictionType" to restrictionType.ordinal
    ).toWritableMap()
}
