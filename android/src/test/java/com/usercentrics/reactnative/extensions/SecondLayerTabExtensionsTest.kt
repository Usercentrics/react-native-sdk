package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.JavaOnlyMap
import com.usercentrics.sdk.models.settings.SecondLayerTab
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class SecondLayerTabExtensionsTest {

    @Test
    fun `secondLayerTab maps SERVICES and PARTNERS`() {
        assertEquals(SecondLayerTab.SERVICES, JavaOnlyMap().apply { putString("tab", "SERVICES") }.secondLayerTab())
        assertEquals(SecondLayerTab.PARTNERS, JavaOnlyMap().apply { putString("tab", "PARTNERS") }.secondLayerTab())
    }

    @Test
    fun `secondLayerTab keeps the banner settings keys independent of the tab`() {
        val map = JavaOnlyMap().apply {
            putString("variant", "A")
            putString("tab", "PARTNERS")
        }

        assertEquals(SecondLayerTab.PARTNERS, map.secondLayerTab())
    }

    @Test
    fun `secondLayerTab falls back to the default tab for a null map`() {
        val map: JavaOnlyMap? = null

        assertNull(map.secondLayerTab())
    }

    @Test
    fun `secondLayerTab falls back to the default tab for a missing key`() {
        assertNull(JavaOnlyMap().secondLayerTab())
    }

    @Test
    fun `secondLayerTab falls back to the default tab for a null value`() {
        assertNull(JavaOnlyMap().apply { putNull("tab") }.secondLayerTab())
    }

    @Test
    fun `secondLayerTab falls back to the default tab for an unknown or non-string value`() {
        assertNull(JavaOnlyMap().apply { putString("tab", "UNKNOWN") }.secondLayerTab())
        assertNull(JavaOnlyMap().apply { putString("tab", "services") }.secondLayerTab())
        assertNull(JavaOnlyMap().apply { putInt("tab", 1) }.secondLayerTab())
        assertNull(JavaOnlyMap().apply { putBoolean("tab", true) }.secondLayerTab())
    }
}
