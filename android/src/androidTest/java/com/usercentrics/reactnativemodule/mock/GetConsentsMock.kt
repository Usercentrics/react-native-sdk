package com.usercentrics.reactnativemodule.mock

import com.usercentrics.sdk.UsercentricsServiceConsent
import com.usercentrics.sdk.models.settings.UsercentricsConsentType

internal class GetConsentsMock {
    companion object {
        val fakeWithData = listOf(
            UsercentricsServiceConsent(
                templateId = "ocv9HNX_g",
                status = false,
                dataProcessor = "Facebook SDK",
                type = UsercentricsConsentType.EXPLICIT,
                version = "1.0.1"
            )
        )

        val expectedWithData = listOf(
            mapOf(
                "templateId" to "ocv9HNX_g",
                "status" to false,
                "type" to 0,
                "version" to "1.0.1",
                "dataProcessor" to "Facebook SDK",
            )
        )
    }
}