package com.usercentrics.reactnativemodule.mock

import com.usercentrics.sdk.UserDecision

internal class SaveDecisionsMock {
    companion object {
        val callDecisions = listOf(
            UserDecision(
                consent = true,
                serviceId = "ocv9HNX_g"
            )
        )
    }
}
