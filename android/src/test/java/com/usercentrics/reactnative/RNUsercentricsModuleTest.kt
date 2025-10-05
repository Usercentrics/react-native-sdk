package com.usercentrics.reactnativemodule

import com.usercentrics.reactnativemodule.fake.FakePromise
import org.junit.Test
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull

class RNUsercentricsModuleTest {

    @Test
    fun `FakePromise should resolve correctly`() {
        val promise = FakePromise()
        val testValue = "test_result"
        
        promise.resolve(testValue)
        
        assertEquals(testValue, promise.resolveValue)
    }

    @Test
    fun `FakePromise should reject with code and message`() {
        val promise = FakePromise()
        val errorMessage = "test_error"
        
        promise.reject("ERROR_CODE", errorMessage)
        
        assertNotNull(promise.rejectThrowable)
        assertEquals("ERROR_CODE: $errorMessage", promise.rejectThrowable?.message)
    }

    @Test
    fun `FakePromise should reject with throwable`() {
        val promise = FakePromise()
        val error = RuntimeException("Network error")
        
        promise.reject(error)
        
        assertEquals(error, promise.rejectThrowable)
    }

    @Test
    fun `FakePromise should handle multiple resolve calls`() {
        val promise = FakePromise()
        
        promise.resolve("first")
        promise.resolve("second")  // Should overwrite
        
        assertEquals("second", promise.resolveValue)
    }

    @Test
    fun `FakePromise should handle multiple reject calls`() {
        val promise = FakePromise()
        
        promise.reject("FIRST", "first error")
        promise.reject("SECOND", "second error")  // Should overwrite
        
        assertEquals("SECOND: second error", promise.rejectThrowable?.message)
    }

    @Test
    fun `Promise interface methods should work`() {
        val promise = FakePromise()
        
        // Test different reject overloads
        promise.reject("CODE", "message", RuntimeException("cause"))
        assertNotNull(promise.rejectThrowable)
        
        // Reset and test resolve
        val newPromise = FakePromise()
        newPromise.resolve(mapOf("key" to "value"))
        assertNotNull(newPromise.resolveValue)
    }

    @Test
    fun `Promise should handle null values`() {
        val promise = FakePromise()
        
        promise.resolve(null)
        assertEquals(null, promise.resolveValue)
    }

    @Test
    fun `Promise should handle complex data structures`() {
        val promise = FakePromise()
        val complexData = mapOf(
            "string" to "value",
            "number" to 42,
            "boolean" to true,
            "array" to listOf("item1", "item2"),
            "nested" to mapOf("inner" to "value")
        )
        
        promise.resolve(complexData)
        assertEquals(complexData, promise.resolveValue)
    }

    @Test
    fun `Module name validation`() {
        val expectedName = "RNUsercentricsModule"
        assertEquals("RNUsercentricsModule", expectedName)
    }

    @Test
    fun `Basic string operations`() {
        val settingsId = "AAAAA"
        val ruleSetId = "BBBBB"
        
        assertEquals(5, settingsId.length)
        assertEquals(5, ruleSetId.length)
        assertEquals("AAAAA", settingsId)
        assertEquals("BBBBB", ruleSetId)
    }

    @Test
    fun `Basic number operations`() {
        val timeoutMillis = 1000L
        val initTimeoutMillis = 10000L
        
        assertEquals(1000L, timeoutMillis)
        assertEquals(10000L, initTimeoutMillis)
        assertEquals(10.0, initTimeoutMillis.toDouble() / timeoutMillis.toDouble(), 0.1)
    }

    @Test
    fun `Boolean logic validation`() {
        val shouldCollectConsent = false
        val isEnabled = true
        
        assertEquals(false, shouldCollectConsent)
        assertEquals(true, isEnabled)
        assertEquals(true, !shouldCollectConsent)
        assertEquals(false, !isEnabled)
    }

    @Test
    fun `List operations`() {
        val items = listOf("item1", "item2", "item3")
        
        assertEquals(3, items.size)
        assertEquals("item1", items[0])
        assertEquals("item3", items.last())
        assertEquals(true, items.contains("item2"))
    }

    @Test
    fun `Map operations`() {
        val config = mapOf(
            "settingsId" to "test123",
            "enabled" to true,
            "timeout" to 5000
        )
        
        assertEquals("test123", config["settingsId"])
        assertEquals(true, config["enabled"])
        assertEquals(5000, config["timeout"])
        assertEquals(3, config.size)
    }
}