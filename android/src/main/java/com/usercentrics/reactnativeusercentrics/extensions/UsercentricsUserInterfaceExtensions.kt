package com.usercentrics.reactnativeusercentrics.extensions

import android.content.res.AssetManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Typeface
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.reactnativeusercentrics.R
import com.usercentrics.sdk.UsercentricsFont
import com.usercentrics.sdk.UsercentricsImage
import com.usercentrics.sdk.UsercentricsOptions
import com.usercentrics.sdk.UsercentricsUISettings
import com.usercentrics.sdk.models.common.UsercentricsLoggerLevel

internal fun ReadableMap.usercentricsUISettingsFromMap(assetManager: AssetManager): UsercentricsUISettings {
    val showCloseButton = getBooleanOrNull("showCloseButton") == true
    val customFont = getMap("customFont")
    val customLogo = getMap("customLogo")

    return UsercentricsUISettings(
        customFont?.usercentricsFontFromMap(assetManager),
        customLogo?.usercentricsImageFromMap(),
        showCloseButton
    )
}

internal fun ReadableMap.usercentricsImageFromMap(): UsercentricsImage? {
    val logoPath = getString("logoPath") ?: return null
    return UsercentricsImage.ImageUrl(logoPath)
}

internal fun ReadableMap.usercentricsFontFromMap(assetManager: AssetManager): UsercentricsFont? {
    val fontName = getString("fontName") ?: return null
    val fontSize = getDoubleOrNull("fontSize") ?: return null

    val fontsFolder = assetManager.list("fonts")
    val firstName = fontsFolder?.first { it.startsWith(fontName) } ?: return null

    val typeface = Typeface.createFromAsset(assetManager, "fonts/$firstName")

    return UsercentricsFont(
        typeface,
        fontSize.toFloat()
    )
}