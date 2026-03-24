package com.usercentrics.reactnative.extensions

import com.facebook.react.bridge.JavaOnlyArray
import com.facebook.react.bridge.JavaOnlyMap
import org.junit.Test
import org.junit.Assert.*

/**
 * Tests for nullability handling in React Native 0.77+
 * These tests ensure that null values from ReadableArray/ReadableMap are handled safely
 */
class NullabilityTest {

    @Test
    fun `deserializeUserDecision handles null map entries`() {
        // Given: array with null entries
        val array = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("serviceId", "service1", "consent", true))
            pushNull() // Simulate null entry
            pushMap(JavaOnlyMap.of("serviceId", "service2", "consent", false))
        }

        // When: deserializing
        val result = array.deserializeUserDecision()

        // Then: null entries are skipped, valid entries are processed
        assertEquals(2, result.size)
        assertEquals("service1", result[0].serviceId)
        assertEquals(true, result[0].consent)
        assertEquals("service2", result[1].serviceId)
        assertEquals(false, result[1].consent)
    }

    @Test
    fun `deserializePurposeLIDecisionsMap handles null map entries`() {
        // Given: array with null entries
        val array = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("id", 1, "legitimateInterestConsent", true))
            pushNull() // Simulate null entry
            pushMap(JavaOnlyMap.of("id", 2, "legitimateInterestConsent", false))
        }

        // When: deserializing
        val result = array.deserializePurposeLIDecisionsMap()

        // Then: null entries are skipped
        assertNotNull(result)
        assertEquals(2, result?.size)
        assertEquals(true, result?.get(1))
        assertEquals(false, result?.get(2))
    }

    @Test
    fun `deserializePurposeLIDecisionsMap returns null for empty array`() {
        // Given: empty array
        val array = JavaOnlyArray()

        // When: deserializing
        val result = array.deserializePurposeLIDecisionsMap()

        // Then: returns null
        assertNull(result)
    }

    @Test
    fun `deserializeTCFUserDecisions handles null purpose entries`() {
        // Given: TCF decisions with null entries in purposes array
        val purposesArray = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("id", 1, "consent", true))
            pushNull() // Simulate null entry
            pushMap(JavaOnlyMap.of("id", 2, "consent", false))
        }

        val tcfMap = JavaOnlyMap.of("purposes", purposesArray)

        // When: deserializing
        val result = tcfMap.deserializeTCFUserDecisions()

        // Then: null entries are skipped
        assertNotNull(result.purposes)
        assertEquals(2, result.purposes?.size)
    }

    @Test
    fun `deserializeTCFUserDecisions handles null special features entries`() {
        // Given: TCF decisions with null entries in specialFeatures array
        val specialFeaturesArray = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("id", 1, "consent", true))
            pushNull()
            pushMap(JavaOnlyMap.of("id", 2, "consent", false))
        }

        val tcfMap = JavaOnlyMap.of("specialFeatures", specialFeaturesArray)

        // When: deserializing
        val result = tcfMap.deserializeTCFUserDecisions()

        // Then: null entries are skipped
        assertNotNull(result.specialFeatures)
        assertEquals(2, result.specialFeatures?.size)
    }

    @Test
    fun `deserializeTCFUserDecisions handles null vendors entries`() {
        // Given: TCF decisions with null entries in vendors array
        val vendorsArray = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("id", 1, "consent", true))
            pushNull()
            pushMap(JavaOnlyMap.of("id", 2, "consent", false))
        }

        val tcfMap = JavaOnlyMap.of("vendors", vendorsArray)

        // When: deserializing
        val result = tcfMap.deserializeTCFUserDecisions()

        // Then: null entries are skipped
        assertNotNull(result.vendors)
        assertEquals(2, result.vendors?.size)
    }

    @Test
    fun `deserializeTCFUserDecisions handles null adTechProviders entries`() {
        // Given: TCF decisions with null entries in adTechProviders array
        val adTechArray = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("id", 1, "consent", true))
            pushNull()
            pushMap(JavaOnlyMap.of("id", 2, "consent", false))
        }

        val tcfMap = JavaOnlyMap.of("adTechProviders", adTechArray)

        // When: deserializing
        val result = tcfMap.deserializeTCFUserDecisions()

        // Then: null entries are skipped
        assertNotNull(result.adTechProviders)
        assertEquals(2, result.adTechProviders.size)
    }

    @Test
    fun `deserializeTCFUserDecisions handles missing arrays gracefully`() {
        // Given: empty TCF map
        val tcfMap = JavaOnlyMap()

        // When: deserializing
        val result = tcfMap.deserializeTCFUserDecisions()

        // Then: all fields are null or empty
        assertNull(result.purposes)
        assertNull(result.specialFeatures)
        assertNull(result.vendors)
        assertEquals(0, result.adTechProviders.size)
    }

    @Test
    fun `deserializeUserDecision handles array with all null entries`() {
        // Given: array with only null entries
        val array = JavaOnlyArray().apply {
            pushNull()
            pushNull()
            pushNull()
        }

        // When: deserializing
        val result = array.deserializeUserDecision()

        // Then: returns empty list
        assertEquals(0, result.size)
    }

    @Test
    fun `deserializeUserDecision skips entries with null serviceId`() {
        // Given: array with entry missing serviceId
        val array = JavaOnlyArray().apply {
            pushMap(JavaOnlyMap.of("serviceId", "service1", "consent", true))
            pushMap(JavaOnlyMap.of("consent", false)) // Missing serviceId
            pushMap(JavaOnlyMap.of("serviceId", "service2", "consent", true))
        }

        // When: deserializing
        val result = array.deserializeUserDecision()

        // Then: entry without serviceId is skipped
        assertEquals(2, result.size)
        assertEquals("service1", result[0].serviceId)
        assertEquals("service2", result[1].serviceId)
    }
}
