package com.usercentrics.reactnativeusercentrics.extensions

import android.content.res.AssetManager
import android.graphics.Typeface
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.BannerFont


internal fun ReadableMap.bannerFontFromMap(assetManager: AssetManager): BannerFont? {
    val size = getDoubleOrNull("fontSize") ?: return null
    val regularTypeface = assetManager.createFontFromName(getString("regularFont")) ?: return null
    val boldTypeface = assetManager.createFontFromName(getString("boldFont")) ?: return null

    return BannerFont(
        regularTypeface,
        boldTypeface,
        size.toFloat()
    )
}

internal fun AssetManager.createFontFromName(fontName: String?): Typeface? {
    if (fontName == null) { return null }
    val fontsFolder = this.list("fonts")
    val regularFontName = fontsFolder?.firstOrNull { it.startsWith(fontName) } ?: return null
    return Typeface.createFromAsset(this, "fonts/$regularFontName")
}