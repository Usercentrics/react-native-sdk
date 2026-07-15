package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.JavaOnlyMap
import com.usercentrics.sdk.PurposeListStyle
import org.junit.Assert.*
import org.junit.Test

class BannerInitCustomizationExtensionsTest {

    @Test
    fun `bannerInitCustomizationFromMap maps all fields`() {
        val map = JavaOnlyMap().apply {
            putInt("paddingTop", 16)
            putInt("paddingBottom", 16)
            putInt("paddingStart", 8)
            putInt("paddingEnd", 8)
            putDouble("lineSpacingMultiplier", 1.2)
            putInt("titleFontSize", 18)
            putInt("bodyFontSize", 14)
            putInt("linkFontSize", 14)
            putBoolean("titleFontBold", true)
            putInt("headerPaddingTop", 12)
            putInt("headerPaddingSides", 12)
            putInt("headerPaddingBetweenElements", 4)
            putString("buttonBorderColor", "#004dcf")
            putInt("buttonBorderWidth", 1)
            putString("purposeListStyle", "FLAT")
            putBoolean("stickyHeader", true)
            putBoolean("hideLanguageSwitcher", false)
            putInt("buttonHeightDp", 48)
            putInt("buttonHorizontalPaddingDp", 16)
            putInt("buttonSpacingDp", 8)
            putBoolean("linkUnderline", true)
            putBoolean("showSecondLayerCloseButton", true)
            putInt("tabFontSize", 14)
            putString("tabActiveColor", "#004dcf")
            putString("denyAllButtonBackground", "#ffffff")
            putString("acceptAllButtonBackground", "#004dcf")
            putString("linkColor", "#004dcf")
        }

        val customization = map.bannerInitCustomizationFromMap()

        assertEquals(16, customization.paddingTop)
        assertEquals(16, customization.paddingBottom)
        assertEquals(8, customization.paddingStart)
        assertEquals(8, customization.paddingEnd)
        assertEquals(1.2f, customization.lineSpacingMultiplier)
        assertEquals(18, customization.titleFontSize)
        assertEquals(14, customization.bodyFontSize)
        assertEquals(14, customization.linkFontSize)
        assertEquals(true, customization.titleFontBold)
        assertEquals(12, customization.headerPaddingTop)
        assertEquals(12, customization.headerPaddingSides)
        assertEquals(4, customization.headerPaddingBetweenElements)
        assertEquals("#004dcf", customization.buttonBorderColor)
        assertEquals(1, customization.buttonBorderWidth)
        assertEquals(PurposeListStyle.FLAT, customization.purposeListStyle)
        assertEquals(true, customization.stickyHeader)
        assertEquals(false, customization.hideLanguageSwitcher)
        assertEquals(48, customization.buttonHeightDp)
        assertEquals(16, customization.buttonHorizontalPaddingDp)
        assertEquals(8, customization.buttonSpacingDp)
        assertEquals(true, customization.linkUnderline)
        assertEquals(true, customization.showSecondLayerCloseButton)
        assertEquals(14, customization.tabFontSize)
        assertEquals("#004dcf", customization.tabActiveColor)
        assertEquals("#ffffff", customization.denyAllButtonBackground)
        assertEquals("#004dcf", customization.acceptAllButtonBackground)
        assertEquals("#004dcf", customization.linkColor)
    }

    @Test
    fun `bannerInitCustomizationFromMap omits unset fields instead of defaulting`() {
        val map = JavaOnlyMap()

        val customization = map.bannerInitCustomizationFromMap()

        assertNull(customization.paddingTop)
        assertNull(customization.buttonBorderColor)
        assertNull(customization.purposeListStyle)
        assertNull(customization.stickyHeader)
    }

    @Test
    fun `purposeListStyleFromEnumString maps known values and returns null otherwise`() {
        assertEquals(PurposeListStyle.BOXED, "BOXED".purposeListStyleFromEnumString())
        assertEquals(PurposeListStyle.FLAT, "FLAT".purposeListStyleFromEnumString())
        assertNull("UNKNOWN".purposeListStyleFromEnumString())
    }

    @Test
    fun `usercentricsOptionsFromMap maps nested bannerCustomization`() {
        val map = JavaOnlyMap().apply {
            putString("settingsId", "123")
            putMap("bannerCustomization", JavaOnlyMap().apply {
                putInt("paddingTop", 16)
                putString("purposeListStyle", "FLAT")
            })
        }

        val options = map.usercentricsOptionsFromMap()

        assertEquals(16, options.bannerCustomization?.paddingTop)
        assertEquals(PurposeListStyle.FLAT, options.bannerCustomization?.purposeListStyle)
    }
}
