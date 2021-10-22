package com.usercentrics.reactnativemodule

import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.facebook.react.bridge.JavaOnlyMap
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.WritableMap
import com.facebook.soloader.SoLoader
import com.usercentrics.reactnativemodule.api.FakeUsercentricsProxy
import com.usercentrics.reactnativemodule.fake.FakePromise
import com.usercentrics.reactnativeusercentrics.RNUsercentricsModule
import com.usercentrics.sdk.*
import com.usercentrics.sdk.errors.UsercentricsError
import com.usercentrics.sdk.models.common.UsercentricsLoggerLevel
import com.usercentrics.sdk.models.settings.UsercentricsConsentType
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.Assert.assertEquals
import org.junit.Assert.assertThrows
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class RNUsercentricsModuleTest {

    companion object {
        private val usercentricsOptions = JavaOnlyMap().apply {
            putString("settingsId", "AAAAA")
            putInt("loggerlevel", 0)
            putInt("timeoutMillis", 1000)
            putString("version", "1.2.3")
        }

        private val usercentricsReadyStatus = UsercentricsReadyStatus(
            shouldShowCMP = false,
            consents = listOf(
                UsercentricsServiceConsent(
                    templateId = "ocv9HNX_g",
                    status = false,
                    dataProcessor = "Facebook SDK",
                    type = UsercentricsConsentType.EXPLICIT,
                    version = "1.0.1"
                )
            )
        )

        private val usercentricsUIOptions = JavaOnlyMap().apply {
            putBoolean("showCloseButton", false)
            putMap("customLogo", JavaOnlyMap().apply {
                putString("logoName", "logo.png")
                putString(
                    "logoPath",
                    "http://10.0.2.2:8081/assets/assets/images/logo.png"
                )
            })
            putMap("customFont", JavaOnlyMap().apply {
                putString("fontName", "Lora")
                putInt("fontSize", 14)
            })
        }

        private val usercentricsConsentUserResponse = UsercentricsConsentUserResponse(
            consents = listOf(
                UsercentricsServiceConsent(
                    templateId = "ocv9HNX_g",
                    status = false,
                    dataProcessor = "Facebook SDK",
                    type = UsercentricsConsentType.EXPLICIT,
                    version = "1.0.1"
                )
            ),
            controllerId = "8620135313b043696b806868b20da905886a3a2598ddddc2b52973f9807d6b45",
            userInteraction = UsercentricsUserInteraction.ACCEPT_ALL
        )
    }

    @Before
    fun before() {
        SoLoader.init(
            InstrumentationRegistry.getInstrumentation().context,
            SoLoader.SOLOADER_ALLOW_ASYNC_INIT
        )
    }

    @Test
    fun testModuleName() {
        assertEquals(
            "RNUsercentricsModule",
            RNUsercentricsModule(mockk(relaxed = true), mockk()).name
        )
    }

    @Test
    fun testConfigure() {
        val usercentricsProxy = FakeUsercentricsProxy()
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        module.configure(usercentricsOptions)

        assertEquals(1, usercentricsProxy.initializeCount)
        assertEquals("AAAAA", usercentricsProxy.initializeOptionsArgument?.settingsId)
        assertEquals(
            UsercentricsLoggerLevel.NONE,
            usercentricsProxy.initializeOptionsArgument?.loggerLevel
        )
        assertEquals(1000L, usercentricsProxy.initializeOptionsArgument?.timeoutMillis)
        assertEquals("1.2.3", usercentricsProxy.initializeOptionsArgument?.version)
    }

    @Test
    fun testConfigureWithWrongValues() {
        val usercentricsProxy = FakeUsercentricsProxy()
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        module.configure(JavaOnlyMap())
        assertEquals(null, usercentricsProxy.initializeOptionsArgument)
    }

    @Test
    fun testIsReady() {
        val usercentricsProxy = FakeUsercentricsProxy(isReadyAnswer = usercentricsReadyStatus)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val promise = FakePromise()
        module.isReady(promise)

        val result = promise.resolveValue as WritableMap
        val consent = result.getArray("consents")?.getMap(0)!!

        assertEquals(1, usercentricsProxy.isReadyCount)
        assertEquals(false, result.getBoolean("shouldShowCMP"))
        assertEquals(false, consent.getBoolean("status"))
        assertEquals("ocv9HNX_g", consent.getString("templateId"))
        assertEquals("Facebook SDK", consent.getString("dataProcessor"))
        assertEquals(0, consent.getInt("type"))
        assertEquals("1.0.1", consent.getString("version"))
    }

    @Test
    fun testIsReadyWithError() {
        val error = mockk<UsercentricsError>(relaxed = true)

        val usercentricsProxy = FakeUsercentricsProxy(isReadyAnswer = error)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val promise = FakePromise()
        module.isReady(promise)

        assertEquals(1, usercentricsProxy.isReadyCount)
        assertEquals(error, promise.rejectThrowable)
    }

    @Test
    fun testRestoreUserSession() {
        val usercentricsSDK = mockk<UsercentricsSDK>()
        every { usercentricsSDK.restoreUserSession(any(), any(), any()) }
            .answers {
                (arg(1) as (UsercentricsReadyStatus) -> Unit)(usercentricsReadyStatus)
            }

        val usercentricsProxy = FakeUsercentricsProxy(instanceAnswer = usercentricsSDK)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val promise = FakePromise()
        module.restoreUserSession("abc", promise)

        verify(exactly = 1) { usercentricsSDK.restoreUserSession("abc", any(), any()) }

        val result = promise.resolveValue as WritableMap
        val consent = result.getArray("consents")?.getMap(0)!!

        assertEquals(false, result.getBoolean("shouldShowCMP"))
        assertEquals(false, consent.getBoolean("status"))
        assertEquals("ocv9HNX_g", consent.getString("templateId"))
        assertEquals("Facebook SDK", consent.getString("dataProcessor"))
        assertEquals(0, consent.getInt("type"))
        assertEquals("1.0.1", consent.getString("version"))
    }

    @Test
    fun testRestoreUserSessionWithError() {
        val error = mockk<UsercentricsError>(relaxed = true)
        val usercentricsSDK = mockk<UsercentricsSDK>()
        every { usercentricsSDK.restoreUserSession(any(), any(), any()) }
            .answers {
                (arg(2) as (UsercentricsError) -> Unit)(error)
            }
        val usercentricsProxy = FakeUsercentricsProxy(usercentricsSDK)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val promise = FakePromise()
        module.restoreUserSession("abc", promise)

        verify(exactly = 1) { usercentricsSDK.restoreUserSession("abc", any(), any()) }
        assertEquals(error, promise.rejectThrowable)
    }

    @Test
    fun testGetControllerId() {
        val usercentricsSDK = mockk<UsercentricsSDK>()
        every { usercentricsSDK.getControllerId() }.returns("abc")
        val usercentricsProxy = FakeUsercentricsProxy(usercentricsSDK)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)
        val promise = FakePromise()

        module.getControllerId(promise)

        verify(exactly = 1) { usercentricsSDK.getControllerId() }
        assertEquals("abc", promise.resolveValue)
    }

    @Test
    fun testGetTCString() {
        val usercentricsSDK = mockk<UsercentricsSDK>()
        every { usercentricsSDK.getTCString() }.returns("abc")
        val usercentricsProxy = FakeUsercentricsProxy(usercentricsSDK)
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)
        val promise = FakePromise()

        module.getTCFString(promise)

        verify(exactly = 1) { usercentricsSDK.getTCString() }
        assertEquals("abc", promise.resolveValue)
    }

    @Test
    fun testShowCMP() {
        val usercentricsProxy = FakeUsercentricsProxy()
        usercentricsProxy.createIntentValue = mockk(relaxed = true)

        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)
        val promise = FakePromise()

        module.showCMP(usercentricsUIOptions, promise)

        val responseUsercentricsOptions = usercentricsProxy.usercentricsOptions!!
        val customLogoURL =
            (responseUsercentricsOptions.customLogo as UsercentricsImage.ImageUrl).imageUrl

        assertEquals(false, responseUsercentricsOptions.showCloseButton)
        assertEquals(
            "http://10.0.2.2:8081/assets/assets/images/logo.png",
            customLogoURL
        )
    }

    @Test
    fun testOnActivityResultWithOtherCode() {
        val usercentricsProxy = FakeUsercentricsProxy()
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val otherRequestCode = 123
        val consumed = module.parseActivityResult(otherRequestCode, 123, null)

        assertEquals(false, consumed)
    }

    @Test
    fun testOnActivityResultWithNoPendingResult() {
        val usercentricsProxy = FakeUsercentricsProxy()
        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        assertThrows(AssertionError::class.java) {
            module.parseActivityResult(81420, 123, null)
        }
    }

    @Test
    fun testOnActivityResultWithPendingResult() {
        val resultCode = 123
        val usercentricsProxy = FakeUsercentricsProxy()
        usercentricsProxy.createIntentValue = mockk(relaxed = true)
        usercentricsProxy.parseResultValue = usercentricsConsentUserResponse

        val contextMock = mockk<ReactApplicationContext>(relaxed = true)
        val module = RNUsercentricsModule(contextMock, usercentricsProxy)

        val promise = FakePromise()
        module.showCMP(usercentricsUIOptions, promise)

        module.parseActivityResult(81420, resultCode, null)

        assertEquals(resultCode, usercentricsProxy.parseResultResultCodeArgument)

        val result = promise.resolveValue as WritableMap
        val consent = result.getArray("consents")?.getMap(0)!!
        
        assertEquals(
            "8620135313b043696b806868b20da905886a3a2598ddddc2b52973f9807d6b45",
            result.getString("controllerId")
        )
        assertEquals(0, result.getInt("userInteraction"))

        assertEquals(false, consent.getBoolean("status"))
        assertEquals("ocv9HNX_g", consent.getString("templateId"))
        assertEquals("Facebook SDK", consent.getString("dataProcessor"))
        assertEquals(0, consent.getInt("type"))
        assertEquals("1.0.1", consent.getString("version"))
    }
}