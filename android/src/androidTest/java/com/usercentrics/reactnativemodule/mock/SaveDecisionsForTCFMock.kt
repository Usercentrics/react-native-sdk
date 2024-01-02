package com.usercentrics.reactnativemodule.mock

import com.usercentrics.reactnativeusercentrics.extensions.toWritableMap
import com.usercentrics.sdk.UserDecision
import com.usercentrics.sdk.UsercentricsConsentHistoryEntry
import com.usercentrics.sdk.UsercentricsServiceConsent
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import com.usercentrics.sdk.services.tcf.TCFDecisionUILayer
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnPurpose
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnSpecialFeature
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisionOnVendor
import com.usercentrics.sdk.services.tcf.interfaces.TCFUserDecisions

internal class SaveDecisionsForTCFMock {
    companion object {
        val fake = listOf(
            UsercentricsServiceConsent(
                templateId = "ocv9HNX_g",
                status = true,
                dataProcessor = "Facebook SDK",
                type = UsercentricsConsentType.EXPLICIT,
                version = "1.0.1",
                history = listOf(
                    UsercentricsConsentHistoryEntry(
                        status = false,
                        UsercentricsConsentType.EXPLICIT,
                        123
                    )
                ),
                isEssential = false
            )
        )

        // From the debugger
        val call = mapOf(
            "tcfDecisions" to mapOf(
                "purposes" to listOf(
                    mapOf(
                        "id" to 1,
                        "consent" to true,
                        "legitimateInterestConsent" to null
                    )
                ),
                "specialFeatures" to listOf(
                    mapOf(
                        "id" to 5,
                        "consent" to false,
                    )
                ),
                "vendors" to listOf(
                    mapOf(
                        "id" to 6,
                        "consent" to true,
                        "legitimateInterestConsent" to null
                    )
                ),
                "adTechProviders" to listOf(
                    mapOf(
                        "id" to 43,
                        "consent" to true,
                    )
                )
            ),
            "fromLayer" to "FIRST_LAYER",
            "serviceDecisions" to listOf(
                mapOf(
                    "consent" to true,
                    "serviceId" to "ocv9HNX_g"
                )
            ),
            "consentType" to "EXPLICIT"
        ).toWritableMap()
        val expected = listOf(
            mapOf(
                "templateId" to "ocv9HNX_g",
                "status" to true,
                "type" to 0,
                "version" to "1.0.1",
                "dataProcessor" to "Facebook SDK",
                "isEssential" to false,
                "history" to listOf(
                    mapOf(
                        "timestampInMillis" to 123,
                        "type" to 0,
                        "status" to false
                    )
                )
            )
        )
    }
}
