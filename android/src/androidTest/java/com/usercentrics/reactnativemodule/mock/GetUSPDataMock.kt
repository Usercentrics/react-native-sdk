package com.usercentrics.reactnativemodule.mock

import com.usercentrics.ccpa.CCPAData

internal class GetUSPDataMock {
    companion object {
        val fake = CCPAData(
            version = 1,
            noticeGiven = true,
            optedOut = false,
            lspact = null,
        )

        // From the debugger
        val expected = mapOf(
            "uspString" to "1YN-",
            "version" to 1,
            "noticeGiven" to true,
            "optedOut" to false,
            "lspact" to null,
        )
    }
}