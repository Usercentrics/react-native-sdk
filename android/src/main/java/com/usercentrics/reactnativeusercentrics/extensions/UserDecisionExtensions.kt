package com.usercentrics.reactnativeusercentrics.extensions

import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.UserDecision
import com.usercentrics.sdk.services.tcf.interfaces.AdTechProviderDecision
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnSpecialFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnVendor
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisions

internal fun ReadableArray.deserializeUserDecision(): List<UserDecision> {
    val decisionList = mutableListOf<UserDecision>()
    for (i in 0 until size()) {
        val map = getMap(i)
        map?.let {
            decisionList.add(
                UserDecision(
                    it.getString("serviceId")!!,
                    it.getBoolean("consent")
                )
            )
        }
    }
    return decisionList
}

internal fun ReadableMap.deserializeTCFUserDecisions(): TCFUserDecisions {
    val purposes = getArray("purposes")?.let { purpose ->
        val list = mutableListOf<TCFUserDecisionOnPurpose>()
        for (i in 0 until purpose.size()) {
            purpose.getMap(i)?.let { map -> list.add(map.deserializeTCFUserDecisionOnPurpose()) }
        }
        list
    }

    val specialFeature = getArray("specialFeatures")?.let { feature ->
        val list = mutableListOf<TCFUserDecisionOnSpecialFeature>()
        for (i in 0 until feature.size()) {
            feature.getMap(i)?.let { map -> list.add(map.deserializeTCFUserDecisionOnSpecialFeature()) }
        }
        list
    }

    val vendors = getArray("vendors")?.let { vendor ->
        val list = mutableListOf<TCFUserDecisionOnVendor>()
        for (i in 0 until vendor.size()) {
            vendor.getMap(i)?.let { map -> list.add(map.deserializeTCFUserDecisionOnVendor()) }
        }
        list
    }

    val adTechProviderDecisions = getArray("adTechProviders")?.let { decision ->
        val list = mutableListOf<AdTechProviderDecision>()
        for (i in 0 until decision.size()) {
            decision.getMap(i)?.let { map -> list.add(map.deserializeAdTechProviderDecision()) }
        }
        list
    }

    return TCFUserDecisions(
        purposes = purposes,
        specialFeatures = specialFeature,
        vendors = vendors,
        adTechProviders = adTechProviderDecisions ?: emptyList(),
    )
}

private fun ReadableMap.deserializeTCFUserDecisionOnPurpose(): TCFUserDecisionOnPurpose {
    return TCFUserDecisionOnPurpose(
        id = getInt("id"),
        consent = getBooleanOrNull("consent"),
        legitimateInterestConsent = getBooleanOrNull("legitimateInterestConsent"),
    )
}

private fun ReadableMap.deserializeTCFUserDecisionOnSpecialFeature(): TCFUserDecisionOnSpecialFeature {
    return TCFUserDecisionOnSpecialFeature(
        id = getInt("id"),
        consent = getBooleanOrNull("consent"),
    )
}

private fun ReadableMap.deserializeTCFUserDecisionOnVendor(): TCFUserDecisionOnVendor {
    return TCFUserDecisionOnVendor(
        id = getInt("id"),
        consent = getBooleanOrNull("consent"),
        legitimateInterestConsent = getBooleanOrNull("legitimateInterestConsent"),
    )
}

private fun ReadableMap.deserializeAdTechProviderDecision(): AdTechProviderDecision {
    return AdTechProviderDecision(
        id = getInt("id"),
        consent = getBooleanOrNull("consent") ?: false,
    )
}
