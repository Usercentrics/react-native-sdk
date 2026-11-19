package com.usercentrics.reactnative.extensions

import android.content.Context
import com.facebook.react.bridge.JavaOnlyMap
import com.usercentrics.sdk.LandscapeLayoutSettings
import io.mockk.mockk
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class GeneralStyleSettingsExtensionsTest {

    private val context = mockk<Context>(relaxed = true)

    @Test
    fun `landscapeLayout is mapped when enabled`() {
        val map = JavaOnlyMap().apply {
            putMap("landscapeLayout", JavaOnlyMap().apply { putBoolean("enabled", true) })
        }

        assertEquals(LandscapeLayoutSettings(enabled = true), map.generalStyleSettingsFromMap(context).landscapeLayout)
    }

    @Test
    fun `landscapeLayout without the flag stays disabled`() {
        val map = JavaOnlyMap().apply { putMap("landscapeLayout", JavaOnlyMap()) }

        assertEquals(LandscapeLayoutSettings(enabled = false), map.generalStyleSettingsFromMap(context).landscapeLayout)
    }

    @Test
    fun `landscapeLayout is null when not provided`() {
        assertNull(JavaOnlyMap().generalStyleSettingsFromMap(context).landscapeLayout)
    }
}
