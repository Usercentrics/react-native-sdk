@file:OptIn(ExperimentalAgeSignalsApi::class)

package com.usercentrics.reactnative

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.JavaOnlyMap
import com.usercentrics.reactnative.api.UsercentricsProxy
import com.usercentrics.reactnativemodule.fake.FakePromise
import com.usercentrics.sdk.UsercentricsSDK
import com.usercentrics.sdk.errors.UsercentricsError
import com.usercentrics.sdk.services.ageverification.ExperimentalAgeSignalsApi
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeBand
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalDecision
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalSource
import com.usercentrics.sdk.services.ageverification.UsercentricsAgeSignalTrust
import com.usercentrics.sdk.services.ageverification.UsercentricsPublisherAgeSignal
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.unmockkAll
import io.mockk.verify
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

class RNUsercentricsModuleAgeSignalTest {

    private val sdk = mockk<UsercentricsSDK>()
    private val proxy = mockk<UsercentricsProxy> { every { instance } returns sdk }
    private val module = RNUsercentricsModule(mockk(relaxed = true), proxy, mockk())
    private val promise = FakePromise()

    private val minorDecision = UsercentricsAgeSignalDecision(
        source = UsercentricsAgeSignalSource.PUBLISHER_PROVIDED,
        trust = UsercentricsAgeSignalTrust.PUBLISHER_PROVIDED,
        band = UsercentricsAgeBand.MINOR,
        ageLower = 13,
        ageUpper = 15,
        unavailableReason = null,
    )

    @Before
    fun setUp() {
        // Arguments.createMap() builds a native map, which needs the React Native libraries: a JVM test uses the Java one
        mockkStatic(Arguments::class)
        every { Arguments.createMap() } answers { JavaOnlyMap() }
    }

    @After
    fun tearDown() {
        unmockkAll()
    }

    private fun answerWith(decision: UsercentricsAgeSignalDecision) {
        every { sdk.setAgeSignal(any(), any(), any()) } answers {
            secondArg<(UsercentricsAgeSignalDecision) -> Unit>().invoke(decision)
        }
    }

    @Test
    fun `setAgeSignal hands the signal of the request to the SDK and resolves with the decision`() {
        mockkObject(UsercentricsPublisherAgeSignal.Companion)
        val signal = mockk<UsercentricsPublisherAgeSignal>()
        every { UsercentricsPublisherAgeSignal.between(13, 15, "my-age-gate") } returns signal
        answerWith(minorDecision)

        module.setAgeSignal(
            JavaOnlyMap.of("kind", "between", "lower", 13, "upper", 15, "sourceLabel", "my-age-gate"),
            promise
        )

        verify(exactly = 1) { sdk.setAgeSignal(signal, any(), any()) }
        assertNull(promise.rejectThrowable)
        val resolved = promise.resolveValue as JavaOnlyMap
        assertEquals("PUBLISHER_PROVIDED", resolved.getString("source"))
        assertEquals("PUBLISHER_PROVIDED", resolved.getString("trust"))
        assertEquals("MINOR", resolved.getString("band"))
        assertEquals(13, resolved.getInt("ageLower"))
        assertEquals(15, resolved.getInt("ageUpper"))
        assertTrue(resolved.isNull("unavailableReason"))
        assertEquals(true, resolved.getBoolean("isAvailable"))
    }

    @Test
    fun `setAgeSignal uses the factory that matches the kind`() {
        mockkObject(UsercentricsPublisherAgeSignal.Companion)
        val atLeast = mockk<UsercentricsPublisherAgeSignal>()
        val below = mockk<UsercentricsPublisherAgeSignal>()
        every { UsercentricsPublisherAgeSignal.atLeast(16, null) } returns atLeast
        every { UsercentricsPublisherAgeSignal.below(16, "gate-2") } returns below
        answerWith(minorDecision)

        module.setAgeSignal(JavaOnlyMap.of("kind", "atLeast", "age", 16), FakePromise())
        module.setAgeSignal(JavaOnlyMap.of("kind", "below", "age", 16, "sourceLabel", "gate-2"), FakePromise())

        verify(exactly = 1) { sdk.setAgeSignal(atLeast, any(), any()) }
        verify(exactly = 1) { sdk.setAgeSignal(below, any(), any()) }
        verify(exactly = 2) { sdk.setAgeSignal(any(), any(), any()) }
    }

    @Test
    fun `setAgeSignal resolves a decision without a band with its nulls`() {
        answerWith(
            UsercentricsAgeSignalDecision(
                source = UsercentricsAgeSignalSource.PUBLISHER_PROVIDED,
                trust = null,
                band = null,
                ageLower = null,
                ageUpper = null,
                unavailableReason = null,
            )
        )

        module.setAgeSignal(JavaOnlyMap.of("kind", "atLeast", "age", 16), promise)

        val resolved = promise.resolveValue as JavaOnlyMap
        for (key in listOf("trust", "band", "ageLower", "ageUpper", "unavailableReason")) {
            assertTrue("$key is null", resolved.hasKey(key) && resolved.isNull(key))
        }
        assertFalse(resolved.getBoolean("isAvailable"))
    }

    @Test
    fun `setAgeSignal rejects with the native error as it is, under the age signal error code`() {
        val error = UsercentricsError.create("Invalid age signal: an age is not between 0 and 120")
        every { sdk.setAgeSignal(any(), any(), any()) } answers {
            thirdArg<(UsercentricsError) -> Unit>().invoke(error)
        }

        module.setAgeSignal(JavaOnlyMap.of("kind", "atLeast", "age", 121), promise)

        // The very same error: not wrapped and not re-worded. The code is the one of the malformed request and of iOS,
        // so an app can match on it on both platforms
        assertSame(error, promise.rejectThrowable)
        assertEquals("Invalid age signal: an age is not between 0 and 120", promise.rejectThrowable?.message)
        assertEquals("usercentrics_reactNative_setAgeSignal_error", promise.rejectCode)
        assertNull(promise.resolveValue)
    }

    @Test
    fun `setAgeSignal does not judge the ages, the native layer does`() {
        mockkObject(UsercentricsPublisherAgeSignal.Companion)
        val signal = mockk<UsercentricsPublisherAgeSignal>()
        every { UsercentricsPublisherAgeSignal.between(121, -1, "bad label!") } returns signal
        answerWith(minorDecision)

        module.setAgeSignal(
            JavaOnlyMap.of("kind", "between", "lower", 121, "upper", -1, "sourceLabel", "bad label!"),
            promise
        )

        verify(exactly = 1) { sdk.setAgeSignal(signal, any(), any()) }
    }

    @Test
    fun `setAgeSignal refuses a request it cannot build, with a fixed message, without calling the SDK`() {
        val requests = listOf(
            JavaOnlyMap.of("kind", "atLeast", "age", 16.5, "sourceLabel", "my-secret-label"),
            JavaOnlyMap.of("kind", "atLeast", "sourceLabel", "my-secret-label"),
            JavaOnlyMap.of("kind", "unknown", "age", 16, "sourceLabel", "my-secret-label"),
            JavaOnlyMap.of("kind", "below", "age", 16, "sourceLabel", 5),
            JavaOnlyMap(),
        )

        for (request in requests) {
            val rejected = FakePromise()

            module.setAgeSignal(request, rejected)

            assertNotNull(rejected.rejectThrowable)
            assertEquals(
                "usercentrics_reactNative_setAgeSignal_error: Invalid age signal: the request is malformed",
                rejected.rejectThrowable?.message
            )
            assertEquals("usercentrics_reactNative_setAgeSignal_error", rejected.rejectCode)
            assertNull(rejected.resolveValue)
        }
        verify(exactly = 0) { sdk.setAgeSignal(any(), any(), any()) }
    }
}
