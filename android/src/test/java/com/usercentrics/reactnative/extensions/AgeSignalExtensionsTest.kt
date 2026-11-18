@file:OptIn(ExperimentalAgeSignalsApi::class)

package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.JavaOnlyMap
import com.facebook.react.bridge.ReadableMap
import com.usercentrics.sdk.services.ageverification.ExperimentalAgeSignalsApi
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeBand
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalDecision
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalSource
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalTrust
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalUnavailableReason
import com.usercentrics.sdk.services.ageverification.UsercentricsPublisherAgeSignal
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.unmockkAll
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Test

class AgeSignalExtensionsTest {

    @After
    fun tearDown() {
        unmockkAll()
    }

    private inline fun <reified T : AgeSignalRequest> ReadableMap.requestOf(): T {
        val request = toAgeSignalRequest()
        assertTrue("expected ${T::class.simpleName} but was ${request?.javaClass?.simpleName}", request is T)
        return request as T
    }

    // The map is built in the way JavaScript sends it: numbers are Doubles
    private fun age(kind: String, value: Any?) = JavaOnlyMap.of("kind", kind, "age", value)

    @Test
    fun `toAgeSignalRequest reads atLeast with and without a label`() {
        val withLabel = JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "sourceLabel", "my-age-gate").requestOf<AgeSignalRequest.AtLeast>()
        val withoutLabel = JavaOnlyMap.of("kind", "atLeast", "age", 16.0).requestOf<AgeSignalRequest.AtLeast>()

        assertEquals(16, withLabel.age)
        assertEquals("my-age-gate", withLabel.sourceLabel)
        assertEquals(16, withoutLabel.age)
        assertNull(withoutLabel.sourceLabel)
    }

    @Test
    fun `toAgeSignalRequest reads below with and without a label`() {
        val withLabel = JavaOnlyMap.of("kind", "below", "age", 16.0, "sourceLabel", "gate.v2_A-1").requestOf<AgeSignalRequest.Below>()
        val withoutLabel = JavaOnlyMap.of("kind", "below", "age", 16.0).requestOf<AgeSignalRequest.Below>()

        assertEquals(16, withLabel.age)
        assertEquals("gate.v2_A-1", withLabel.sourceLabel)
        assertEquals(16, withoutLabel.age)
        assertNull(withoutLabel.sourceLabel)
    }

    @Test
    fun `toAgeSignalRequest reads between with and without a label`() {
        val withLabel = JavaOnlyMap.of("kind", "between", "lower", 13.0, "upper", 15.0, "sourceLabel", "my-age-gate").requestOf<AgeSignalRequest.Between>()
        val withoutLabel = JavaOnlyMap.of("kind", "between", "lower", 13.0, "upper", 15.0).requestOf<AgeSignalRequest.Between>()

        assertEquals(13, withLabel.lower)
        assertEquals(15, withLabel.upper)
        assertEquals("my-age-gate", withLabel.sourceLabel)
        assertEquals(13, withoutLabel.lower)
        assertEquals(15, withoutLabel.upper)
        assertNull(withoutLabel.sourceLabel)
    }

    @Test
    fun `toAgeSignalRequest reads ages that are Ints as well as Doubles`() {
        val intAge = JavaOnlyMap().apply {
            putString("kind", "atLeast")
            putInt("age", 16)
        }

        assertEquals(16, intAge.requestOf<AgeSignalRequest.AtLeast>().age)
        assertEquals(16, age("atLeast", 16.0).requestOf<AgeSignalRequest.AtLeast>().age)
        assertEquals(0, age("atLeast", 0.0).requestOf<AgeSignalRequest.AtLeast>().age)
        assertEquals(0, age("atLeast", -0.0).requestOf<AgeSignalRequest.AtLeast>().age)
    }

    @Test
    fun `toAgeSignalRequest treats a null label like a missing one`() {
        val request = JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "sourceLabel", null).requestOf<AgeSignalRequest.AtLeast>()

        assertNull(request.sourceLabel)
    }

    @Test
    fun `toAgeSignalRequest ignores keys that do not belong to the kind`() {
        val request = JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "lower", "x", "upper", null, "other", true).requestOf<AgeSignalRequest.AtLeast>()

        assertEquals(16, request.age)
    }

    @Test
    fun `toAgeSignalRequest does not judge ages or labels, the native layer does`() {
        // Not valid for the native validator, but it is the native validator that says so, with its own fixed message
        assertEquals(121, age("atLeast", 121.0).requestOf<AgeSignalRequest.AtLeast>().age)
        assertEquals(-1, age("below", -1.0).requestOf<AgeSignalRequest.Below>().age)
        assertEquals(Int.MAX_VALUE, age("atLeast", Int.MAX_VALUE.toDouble()).requestOf<AgeSignalRequest.AtLeast>().age)
        assertEquals(Int.MIN_VALUE, age("atLeast", Int.MIN_VALUE.toDouble()).requestOf<AgeSignalRequest.AtLeast>().age)

        val between = JavaOnlyMap.of("kind", "between", "lower", 20.0, "upper", 10.0, "sourceLabel", "not a valid label!").requestOf<AgeSignalRequest.Between>()
        assertEquals(20, between.lower)
        assertEquals(10, between.upper)
        assertEquals("not a valid label!", between.sourceLabel)

        assertEquals("", JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "sourceLabel", "").requestOf<AgeSignalRequest.AtLeast>().sourceLabel)
        val longLabel = "a".repeat(100)
        assertEquals(longLabel, JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "sourceLabel", longLabel).requestOf<AgeSignalRequest.AtLeast>().sourceLabel)
    }

    @Test
    fun `toAgeSignalRequest refuses an unknown, missing or non-string kind`() {
        assertNull(JavaOnlyMap.of("age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", null, "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "UNKNOWN", "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "ATLEAST", "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "atleast", "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "", "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", 1.0, "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", true, "age", 16.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap().toAgeSignalRequest())
    }

    @Test
    fun `toAgeSignalRequest refuses an age it cannot hand over as it is`() {
        val notAnAge = listOf(
            null, // null
            16.5, // a fraction: getInt would take it for 16
            -0.5, // would become 0
            Double.NaN, // would become 0
            Double.POSITIVE_INFINITY,
            Double.NEGATIVE_INFINITY,
            Int.MAX_VALUE.toDouble() + 1,
            Int.MIN_VALUE.toDouble() - 1,
            3.0e9,
            "16", // a string
            true, // a boolean
        )

        for (kind in listOf("atLeast", "below")) {
            for (value in notAnAge) {
                assertNull("$kind with ${value?.javaClass?.simpleName}", age(kind, value).toAgeSignalRequest())
            }
            assertNull("$kind without an age", JavaOnlyMap.of("kind", kind).toAgeSignalRequest())
        }

        for (value in notAnAge) {
            assertNull("between, lower", JavaOnlyMap.of("kind", "between", "lower", value, "upper", 15.0).toAgeSignalRequest())
            assertNull("between, upper", JavaOnlyMap.of("kind", "between", "lower", 13.0, "upper", value).toAgeSignalRequest())
        }
        assertNull(JavaOnlyMap.of("kind", "between", "lower", 13.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "between", "upper", 15.0).toAgeSignalRequest())
        // atLeast and below take age only, between takes lower and upper only
        assertNull(JavaOnlyMap.of("kind", "between", "age", 13.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "atLeast", "lower", 13.0, "upper", 15.0).toAgeSignalRequest())
    }

    @Test
    fun `toAgeSignalRequest refuses a label that is not a string`() {
        assertNull(JavaOnlyMap.of("kind", "atLeast", "age", 16.0, "sourceLabel", 5.0).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "below", "age", 16.0, "sourceLabel", true).toAgeSignalRequest())
        assertNull(JavaOnlyMap.of("kind", "between", "lower", 13.0, "upper", 15.0, "sourceLabel", JavaOnlyMap()).toAgeSignalRequest())
    }

    @Test
    fun `an AgeSignalRequest never prints the ages or the label`() {
        val requests = listOf(
            AgeSignalRequest.AtLeast(16, "my-age-gate"),
            AgeSignalRequest.Below(17, "my-age-gate"),
            AgeSignalRequest.Between(13, 15, "my-age-gate"),
        )

        for (request in requests) {
            assertEquals("AgeSignalRequest", request.toString())
        }
    }

    @Test
    fun `toPublisherAgeSignal calls the native factory of the kind with the same arguments`() {
        mockkObject(UsercentricsPublisherAgeSignal.Companion)
        val atLeast = mockk<UsercentricsPublisherAgeSignal>()
        val below = mockk<UsercentricsPublisherAgeSignal>()
        val between = mockk<UsercentricsPublisherAgeSignal>()
        val withoutLabel = mockk<UsercentricsPublisherAgeSignal>()
        every { UsercentricsPublisherAgeSignal.atLeast(16, "my-age-gate") } returns atLeast
        every { UsercentricsPublisherAgeSignal.below(17, "gate-2") } returns below
        every { UsercentricsPublisherAgeSignal.between(13, 15, "gate-3") } returns between
        every { UsercentricsPublisherAgeSignal.atLeast(18, null) } returns withoutLabel

        assertSame(atLeast, AgeSignalRequest.AtLeast(16, "my-age-gate").toPublisherAgeSignal())
        assertSame(below, AgeSignalRequest.Below(17, "gate-2").toPublisherAgeSignal())
        assertSame(between, AgeSignalRequest.Between(13, 15, "gate-3").toPublisherAgeSignal())
        assertSame(withoutLabel, AgeSignalRequest.AtLeast(18, null).toPublisherAgeSignal())
    }

    private fun mockArguments() {
        // Arguments.createMap() builds a native map, which needs the React Native libraries: a JVM test uses the Java one
        mockkStatic(Arguments::class)
        every { Arguments.createMap() } answers { JavaOnlyMap() }
    }

    @Test
    fun `toWritableMap writes every field of an available decision`() {
        mockArguments()

        val map = UsercentricsAgeSignalDecision(
            source = UsercentricsAgeSignalSource.PUBLISHER_PROVIDED,
            trust = UsercentricsAgeSignalTrust.PUBLISHER_PROVIDED,
            band = UsercentricsAgeBand.MINOR,
            ageLower = 16,
            ageUpper = null,
            unavailableReason = null,
        ).toWritableMap() as JavaOnlyMap

        assertEquals("PUBLISHER_PROVIDED", map.getString("source"))
        assertEquals("PUBLISHER_PROVIDED", map.getString("trust"))
        assertEquals("MINOR", map.getString("band"))
        assertEquals(16, map.getInt("ageLower"))
        assertTrue(map.hasKey("ageUpper") && map.isNull("ageUpper"))
        assertTrue(map.hasKey("unavailableReason") && map.isNull("unavailableReason"))
        assertEquals(true, map.getBoolean("isAvailable"))
        assertEquals(
            setOf("source", "trust", "band", "ageLower", "ageUpper", "unavailableReason", "isAvailable"),
            map.toHashMap().keys
        )
    }

    @Test
    fun `toWritableMap writes both ages of a range`() {
        mockArguments()

        val map = UsercentricsAgeSignalDecision(
            source = UsercentricsAgeSignalSource.PUBLISHER_PROVIDED,
            trust = UsercentricsAgeSignalTrust.PUBLISHER_PROVIDED,
            band = UsercentricsAgeBand.BELOW_MINIMUM,
            ageLower = 0,
            ageUpper = 12,
            unavailableReason = null,
        ).toWritableMap() as JavaOnlyMap

        assertEquals("BELOW_MINIMUM", map.getString("band"))
        assertEquals(0, map.getInt("ageLower"))
        assertEquals(12, map.getInt("ageUpper"))
        assertEquals(true, map.getBoolean("isAvailable"))
    }

    @Test
    fun `toWritableMap keeps the nulls of a decision without a band`() {
        mockArguments()

        val map = UsercentricsAgeSignalDecision(
            source = UsercentricsAgeSignalSource.GOOGLE_PLAY_AGE_SIGNALS,
            trust = null,
            band = null,
            ageLower = null,
            ageUpper = null,
            unavailableReason = UsercentricsAgeSignalUnavailableReason.NOT_SHARED,
        ).toWritableMap() as JavaOnlyMap

        assertEquals("GOOGLE_PLAY_AGE_SIGNALS", map.getString("source"))
        assertEquals("NOT_SHARED", map.getString("unavailableReason"))
        for (key in listOf("trust", "band", "ageLower", "ageUpper")) {
            assertTrue("$key is null", map.hasKey(key) && map.isNull(key))
        }
        assertFalse(map.getBoolean("isAvailable"))
    }

    @Test
    fun `toWritableMap writes the native name of every enum member`() {
        mockArguments()

        for (source in UsercentricsAgeSignalSource.values()) {
            val decision = UsercentricsAgeSignalDecision(source, null, null, null, null, null)
            assertEquals(source.name, (decision.toWritableMap() as JavaOnlyMap).getString("source"))
        }
        for (trust in UsercentricsAgeSignalTrust.values()) {
            val decision = UsercentricsAgeSignalDecision(UsercentricsAgeSignalSource.PUBLISHER_PROVIDED, trust, null, null, null, null)
            assertEquals(trust.name, (decision.toWritableMap() as JavaOnlyMap).getString("trust"))
        }
        for (band in UsercentricsAgeBand.values()) {
            val decision = UsercentricsAgeSignalDecision(UsercentricsAgeSignalSource.PUBLISHER_PROVIDED, null, band, null, null, null)
            assertEquals(band.name, (decision.toWritableMap() as JavaOnlyMap).getString("band"))
        }
        for (reason in UsercentricsAgeSignalUnavailableReason.values()) {
            val decision = UsercentricsAgeSignalDecision(UsercentricsAgeSignalSource.PUBLISHER_PROVIDED, null, null, null, null, reason)
            assertEquals(reason.name, (decision.toWritableMap() as JavaOnlyMap).getString("unavailableReason"))
        }
    }

    @Test
    fun `the native enums have exactly the members of the JavaScript and iOS enums`() {
        // The names travel as they are: a member that is added or renamed natively must be added to the bridges too
        assertEquals(listOf("BELOW_MINIMUM", "MINOR", "STANDARD"), UsercentricsAgeBand.values().map { it.name })
        assertEquals(
            listOf("APPLE_DECLARED_AGE_RANGE", "GOOGLE_PLAY_AGE_SIGNALS", "PUBLISHER_PROVIDED"),
            UsercentricsAgeSignalSource.values().map { it.name }
        )
        assertEquals(
            listOf("SELF_DECLARED", "GUARDIAN_DECLARED", "VERIFIED", "PUBLISHER_PROVIDED"),
            UsercentricsAgeSignalTrust.values().map { it.name }
        )
        assertEquals(
            listOf(
                "DECLINED", "NOT_SHARED", "VERIFICATION_REQUIRED", "UNSUPPORTED", "NOT_AVAILABLE",
                "INVALID_REQUEST", "TRANSIENT_ERROR", "TIMEOUT", "ERROR"
            ),
            UsercentricsAgeSignalUnavailableReason.values().map { it.name }
        )
    }
}
