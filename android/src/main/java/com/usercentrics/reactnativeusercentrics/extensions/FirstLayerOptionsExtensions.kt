package com.usercentrics.reactnativeusercentrics.extensions

import android.content.res.AssetManager
import android.graphics.Color
import androidx.annotation.ColorInt
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.*

internal fun String.usercentricsLayoutFromEnumString(): UsercentricsLayout {
    return when (this) {
        "FULL" -> UsercentricsLayout.Full
        "SHEET" -> UsercentricsLayout.Sheet
        "POPUP_BOTTOM" -> UsercentricsLayout.Popup(PopupPosition.BOTTOM)
        "POPUP_CENTER" -> UsercentricsLayout.Popup(PopupPosition.CENTER)
        else -> throw IllegalArgumentException("Invalid layout: $this")
    }
}

internal fun ReadableMap.bannerSettingsFromMap(assetManager: AssetManager): BannerSettings {
    val customFont = getMap("font")
    val customLogo = getMap("logo")

    return BannerSettings(
        customFont?.usercentricsFontFromMap(assetManager),
        customLogo?.usercentricsImageFromMap()
    )
}

internal fun ReadableMap.firstLayerStyleSettingsFromMap(assetManager: AssetManager): FirstLayerStyleSettings {
    return FirstLayerStyleSettings(
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

    val image = getMap("image")?.usercentricsImageFromMap() ?: return null

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
    val font = getMap("font")?.usercentricsFontFromMap(assetManager)
    return TitleSettings(
        alignment = getString("alignment")?.sectionAlignmentFromMap(),
        textColor = getString("textColorHex")?.deserializeColor(),
        font = font?.font,
        textSizeInSp = font?.sizeInSp
    )
}

internal fun ReadableMap.messageFromMap(assetManager: AssetManager): MessageSettings {
    val font = getMap("font")?.usercentricsFontFromMap(assetManager)

    return MessageSettings(
        font = font?.font,
        textSizeInSp = font?.sizeInSp,
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
    val font = getMap("font")?.usercentricsFontFromMap(assetManager)
    return ButtonSettings(
        type = getString("buttonType")!!.deserializeButtonType(),
        isAllCaps = getBooleanOrNull("isAllCaps"),
        font = font?.font,
        textColor = getString("textColorHex")?.deserializeColor(),
        backgroundColor = getString("backgroundColorHex")?.deserializeColor(),
        cornerRadius = getIntOrNull("cornerRadius"),
        textSizeInSp = font?.sizeInSp
    )
}

internal fun String.deserializeButtonType(): ButtonType {
    return ButtonType.valueOf(this)
}

@ColorInt
internal fun String.deserializeColor(): Int? {
    val colorString: String =
        if (!this.startsWith("#")) {
            "#$this"
        } else {
            this
        }

    return runCatching {
        Color.parseColor(colorString)
    }.getOrNull()
}
