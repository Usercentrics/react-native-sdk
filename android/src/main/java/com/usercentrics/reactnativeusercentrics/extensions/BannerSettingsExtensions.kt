package com.usercentrics.reactnativeusercentrics.extensions

import android.content.res.AssetManager
import android.graphics.Color
import androidx.annotation.ColorInt
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.*

internal fun String.usercentricsLayoutFromEnumString(): UsercentricsLayout? {
    return when (this) {
        "FULL" -> UsercentricsLayout.Full
        "SHEET" -> UsercentricsLayout.Sheet
        "POPUP_BOTTOM" -> UsercentricsLayout.Popup(PopupPosition.BOTTOM)
        "POPUP_CENTER" -> UsercentricsLayout.Popup(PopupPosition.CENTER)
        else -> null
    }
}

internal fun ReadableMap.bannerSettingsFromMap(assetManager: AssetManager): BannerSettings {
    val rawFirstLayerStyleSettings = getMap("firstLayerStyleSettings")
    val rawSecondLayerStyleSettings = getMap("secondLayerStyleSettings")
    val rawGeneralStyleSettings = getMap("generalStyleSettings")

    return BannerSettings(
        firstLayerStyleSettings =
        rawFirstLayerStyleSettings?.firstLayerStyleSettingsFromMap(assetManager),
        secondLayerStyleSettings =
        rawSecondLayerStyleSettings?.secondLayerStyleSettingsFromMap(assetManager),
        generalStyleSettings = rawGeneralStyleSettings?.generalStyleSettingsFromMap(assetManager),
        variantName = getString("variantName"),
    )
}

internal fun ReadableMap.bannerLogoFromMap(): UsercentricsImage? {
    val logoPath = getString("logoPath") ?: return null
    return UsercentricsImage.ImageUrl(logoPath)
}

internal fun ReadableMap.firstLayerStyleSettingsFromMap(assetManager: AssetManager): FirstLayerStyleSettings {
    return FirstLayerStyleSettings(
        layout = getString("layout")?.usercentricsLayoutFromEnumString(),
        headerImage = getMap("headerImage")?.headerImageFromMap(),
        title = getMap("title")?.titleFromMap(assetManager),
        message = getMap("message")?.messageFromMap(assetManager),
        buttonLayout = getMap("buttonLayout")?.buttonLayoutFromMap(assetManager),
        backgroundColor = getString("backgroundColorHex")?.deserializeColor(),
        overlayColor = getString("overlayColorHex")?.deserializeColor(),
        cornerRadius = getIntOrNull("cornerRadius")
    )
}

internal fun ReadableMap.headerImageFromMap(): HeaderImageSettings? {
    val isHidden = getBooleanOrNull("isHidden") ?: false
    if (isHidden) {
        return HeaderImageSettings.Hidden
    }

    val image = getMap("image")?.bannerLogoFromMap() ?: return null

    val isExtended = getBooleanOrNull("isExtended") ?: false
    return if (isExtended) {
        HeaderImageSettings.ExtendedLogoSettings(image)
    } else {
        HeaderImageSettings.LogoSettings(
            image = image,
            alignment = getString("alignment")?.sectionAlignmentFromMap(),
            heightInDp = getDoubleOrNull("height")?.toFloat()
        )
    }
}

internal fun ReadableMap.titleFromMap(assetManager: AssetManager): TitleSettings {
    return TitleSettings(
        alignment = getString("alignment")?.sectionAlignmentFromMap(),
        textColor = getString("textColorHex")?.deserializeColor(),
        font = assetManager.createFontFromName(getString("fontName")),
        textSizeInSp = getDoubleOrNull("textSize")?.toFloat()
    )
}

internal fun ReadableMap.messageFromMap(assetManager: AssetManager): MessageSettings {
    return MessageSettings(
        font = assetManager.createFontFromName(getString("fontName")),
        textSizeInSp = getDoubleOrNull("textSize")?.toFloat(),
        textColor = getString("textColorHex")?.deserializeColor(),
        alignment = getString("alignment")?.sectionAlignmentFromMap(),
        linkTextColor = getString("linkTextColorHex")?.deserializeColor(),
        underlineLink = getBooleanOrNull("linkTextUnderline")
    )
}

internal fun String.sectionAlignmentFromMap(): SectionAlignment {
    return SectionAlignment.valueOf(this)
}

internal fun ReadableMap.buttonLayoutFromMap(
    assetManager: AssetManager
): ButtonLayout? {
    val layout = getString("layout")
    val buttons: List<List<ButtonSettings>> = getArray("buttons")?.let { buttonsArray ->
        val buttonsList: MutableList<List<ButtonSettings>> = mutableListOf()

        for (rowIndex in 0 until buttonsArray.size()) {
            val listRow = mutableListOf<ButtonSettings>()
            val row = buttonsArray.getArray(rowIndex)
            for (rowElement in 0 until row.size()) {
                val element = row.getMap(rowElement)
                listRow.add(element.buttonSettingsFromMap(assetManager))
            }
            buttonsList.add(listRow)
        }

        return@let buttonsList.toList()
    } ?: listOf()

    when (layout) {
        "ROW" -> {
            return ButtonLayout.Row(
                buttons.flatten()
            )
        }
        "COLUMN" -> {
            return ButtonLayout.Column(
                buttons.flatten()
            )
        }
        "GRID" -> {
            return ButtonLayout.Grid(
                buttons
            )
        }
    }

    return null
}

internal fun ReadableMap.buttonSettingsFromMap(
    assetManager: AssetManager
): ButtonSettings {
    return ButtonSettings(
        type = getString("buttonType")!!.deserializeButtonType(),
        isAllCaps = getBooleanOrNull("isAllCaps"),
        font = assetManager.createFontFromName(getString("fontName")),
        textColor = getString("textColorHex")?.deserializeColor(),
        backgroundColor = getString("backgroundColorHex")?.deserializeColor(),
        cornerRadius = getIntOrNull("cornerRadius"),
        textSizeInSp = getDoubleOrNull("textSize")?.toFloat()
    )
}

internal fun String.deserializeButtonType(): ButtonType {
    return ButtonType.valueOf(this)
}

internal fun ReadableMap.secondLayerStyleSettingsFromMap(assetManager: AssetManager): SecondLayerStyleSettings {
    return SecondLayerStyleSettings(
        buttonLayout = getMap("buttonLayout")?.buttonLayoutFromMap(assetManager),
        showCloseButton = getBoolean("showCloseButton"),
    )
}

internal fun ReadableMap.generalStyleSettingsFromMap(assetManager: AssetManager): GeneralStyleSettings {
    val rawToggleStyleSettings = getMap("toggleStyleSettings")
    return GeneralStyleSettings(
        textColor = getString("textColorHex")?.deserializeColor(),
        layerBackgroundColor = getString("layerBackgroundColorHex")?.deserializeColor(),
        layerBackgroundSecondaryColor = getString("layerBackgroundSecondaryColorHex")?.deserializeColor(),
        linkColor = getString("linkColorHex")?.deserializeColor(),
        tabColor = getString("tabColorHex")?.deserializeColor(),
        bordersColor = getString("bordersColorHex")?.deserializeColor(),
        toggleStyleSettings = rawToggleStyleSettings?.toggleStyleSettingsFromMap(),
        font = getMap("font")?.bannerFontFromMap(assetManager),
        logo = getMap("logo")?.bannerLogoFromMap(),
        links = getString("links")?.legalLinksFromEnumString(),
        disableSystemBackButton = getBooleanOrNull("disableSystemBackButton")
    )
}

internal fun ReadableMap.toggleStyleSettingsFromMap(): ToggleStyleSettings {
    return ToggleStyleSettings(
        activeBackgroundColor = getString("activeBackgroundColorHex")?.deserializeColor(),
        inactiveBackgroundColor = getString("inactiveBackgroundColorHex")?.deserializeColor(),
        disabledBackgroundColor = getString("disabledBackgroundColorHex")?.deserializeColor(),
        activeThumbColor = getString("activeThumbColorHex")?.deserializeColor(),
        inactiveThumbColor = getString("inactiveThumbColorHex")?.deserializeColor(),
        disabledThumbColor = getString("disabledThumbColorHex")?.deserializeColor(),
    )
}

internal fun String?.legalLinksFromEnumString(): LegalLinksSettings? {
    return when (this) {
        "BOTH" -> LegalLinksSettings.BOTH
        "NONE" -> LegalLinksSettings.NONE
        "FIRST_LAYER_ONLY" -> LegalLinksSettings.FIRST_LAYER_ONLY
        "SECOND_LAYER_ONLY" -> LegalLinksSettings.SECOND_LAYER_ONLY
        else -> null
    }
}

@ColorInt
internal fun String.deserializeColor(): Int? {
    val colorString: String = if (!this.startsWith("#")) {
        "#$this"
    } else {
        this
    }
    return runCatching { Color.parseColor(colorString) }.getOrNull()
}
