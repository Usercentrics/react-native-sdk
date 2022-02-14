package com.usercentrics.reactnativemodule.mock

import com.usercentrics.reactnativeusercentrics.extensions.toWritableMap

internal class ShowFirstLayerMock {
    companion object {
        val arguments = mapOf(
            "layout" to "POPUP_CENTER",
            "bannerSettings" to mapOf(
                "font" to null,
                "logo" to null,
            ),
            "styleSettings" to mapOf(
                "headerImage" to null,
                "title" to mapOf(
                    "alignment" to "END",
                    "textSize" to 20.0,
                ),
                "message" to mapOf(
                    "alignment" to "CENTER",
                    "textSize" to 16,
                ),
                "cornerRadius" to 50
            ),
        ).toWritableMap()
    }
}