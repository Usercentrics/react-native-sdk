@file:OptIn(ExperimentalAgeSignalsApi::class)

package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.ReadableType
import com.facebook.react.bridge.WritableMap
import com.usercentrics.sdk.services.ageverification.ExperimentalAgeSignalsApi
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalDecision
import com.usercentrics.sdk.services.ageverification.UsercentricsPublisherAgeSignal
import kotlin.math.floor

// Experimental, like the native age signal API it bridges (setAgeSignal, signal receiver mode).
//
// The request is only transported: the native layer checks the ages and the label, and answers with a fixed message that
// does not repeat them. What the bridge refuses itself is a request it cannot turn into a native signal: an unknown kind,
// an age that is missing or is not a whole number that fits an Int (a Double would be silently truncated, and NaN would
// become age 0), or a label that is not a string. Nothing in here logs a request or a decision: they carry the ages.

/** What `Usercentrics.setAgeSignal` sends from JavaScript: one case for each factory of `UsercentricsPublisherAgeSignal`. */
internal sealed class AgeSignalRequest {

    abstract val sourceLabel: String?

    class AtLeast(val age: Int, override val sourceLabel: String?) : AgeSignalRequest()

    class Below(val age: Int, override val sourceLabel: String?) : AgeSignalRequest()

    class Between(val lower: Int, val upper: Int, override val sourceLabel: String?) : AgeSignalRequest()

    // Constant on purpose, like the native signal: whoever logs a request ships neither the ages nor the label
    final override fun toString(): String = "AgeSignalRequest"
}

/**
 * The request in [this] map (`kind` is "atLeast", "below" or "between", with `age`, or `lower` and `upper`, and an
 * optional `sourceLabel`), or `null` when it cannot be turned into a native signal. A missing key and a null value are
 * the same thing. Keys that do not belong to the kind are ignored.
 */
internal fun ReadableMap.toAgeSignalRequest(): AgeSignalRequest? {
    val sourceLabel = when {
        isAbsent("sourceLabel") -> null
        getType("sourceLabel") == ReadableType.String -> getString("sourceLabel")
        else -> return null
    }

    return when (stringOrNull("kind")) {
        "atLeast" -> AgeSignalRequest.AtLeast(wholeIntOrNull("age") ?: return null, sourceLabel)
        "below" -> AgeSignalRequest.Below(wholeIntOrNull("age") ?: return null, sourceLabel)
        "between" -> AgeSignalRequest.Between(
            lower = wholeIntOrNull("lower") ?: return null,
            upper = wholeIntOrNull("upper") ?: return null,
            sourceLabel = sourceLabel,
        )

        else -> null
    }
}

internal fun AgeSignalRequest.toPublisherAgeSignal(): UsercentricsPublisherAgeSignal = when (this) {
    is AgeSignalRequest.AtLeast -> UsercentricsPublisherAgeSignal.atLeast(age, sourceLabel)
    is AgeSignalRequest.Below -> UsercentricsPublisherAgeSignal.below(age, sourceLabel)
    is AgeSignalRequest.Between -> UsercentricsPublisherAgeSignal.between(lower, upper, sourceLabel)
}

// Enums travel by their native NAME (for example "GOOGLE_PLAY_AGE_SIGNALS") and nulls stay null
internal fun UsercentricsAgeSignalDecision.toWritableMap(): WritableMap {
    return Arguments.createMap().apply {
        putString("source", source.name)
        putString("trust", trust?.name)
        putString("band", band?.name)
        putIntOrNull("ageLower", ageLower)
        putIntOrNull("ageUpper", ageUpper)
        putString("unavailableReason", unavailableReason?.name)
        putBoolean("isAvailable", isAvailable)
    }
}

private fun ReadableMap.isAbsent(key: String): Boolean = !hasKey(key) || isNull(key)

private fun ReadableMap.stringOrNull(key: String): String? {
    return if (hasKey(key) && getType(key) == ReadableType.String) getString(key) else null
}

// `getInt` would truncate 16.5 to 16 and turn NaN into 0, that is, accept a different age than the one that was sent
private fun ReadableMap.wholeIntOrNull(key: String): Int? {
    if (!hasKey(key) || getType(key) != ReadableType.Number) {
        return null
    }
    val value = getDouble(key)
    val isWholeInt = value == floor(value) && value >= Int.MIN_VALUE && value <= Int.MAX_VALUE
    return if (isWholeInt) value.toInt() else null
}

private fun WritableMap.putIntOrNull(key: String, value: Int?) {
    if (value == null) putNull(key) else putInt(key, value)
}
