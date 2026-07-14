package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.BannerInitCustomization
import com.usercentrics.sdk.PurposeListStyle

internal fun ReadableMap.bannerInitCustomizationFromMap(): BannerInitCustomization {
    return BannerInitCustomization(
        paddingTop = getIntOrNull("paddingTop"),
        paddingBottom = getIntOrNull("paddingBottom"),
        paddingStart = getIntOrNull("paddingStart"),
        paddingEnd = getIntOrNull("paddingEnd"),
        lineSpacingMultiplier = getFloatOrNull("lineSpacingMultiplier"),
        titleFontSize = getIntOrNull("titleFontSize"),
        bodyFontSize = getIntOrNull("bodyFontSize"),
        linkFontSize = getIntOrNull("linkFontSize"),
        titleFontBold = getBooleanOrNull("titleFontBold"),
        headerPaddingTop = getIntOrNull("headerPaddingTop"),
        headerPaddingSides = getIntOrNull("headerPaddingSides"),
        headerPaddingBetweenElements = getIntOrNull("headerPaddingBetweenElements"),
        buttonBorderColor = getString("buttonBorderColor"),
        buttonBorderWidth = getIntOrNull("buttonBorderWidth"),
        purposeListStyle = getString("purposeListStyle")?.purposeListStyleFromEnumString(),
        stickyHeader = getBooleanOrNull("stickyHeader"),
        hideLanguageSwitcher = getBooleanOrNull("hideLanguageSwitcher"),
        buttonHeightDp = getIntOrNull("buttonHeightDp"),
        buttonHorizontalPaddingDp = getIntOrNull("buttonHorizontalPaddingDp"),
        buttonSpacingDp = getIntOrNull("buttonSpacingDp"),
        linkUnderline = getBooleanOrNull("linkUnderline"),
        showSecondLayerCloseButton = getBooleanOrNull("showSecondLayerCloseButton"),
        tabFontSize = getIntOrNull("tabFontSize"),
        tabActiveColor = getString("tabActiveColor"),
        denyAllButtonBackground = getString("denyAllButtonBackground"),
        acceptAllButtonBackground = getString("acceptAllButtonBackground"),
        linkColor = getString("linkColor"),
    )
}

internal fun String.purposeListStyleFromEnumString(): PurposeListStyle? {
    return when (this) {
        "BOXED" -> PurposeListStyle.BOXED
        "FLAT" -> PurposeListStyle.FLAT
        else -> null
    }
}
