package com.usercentrics.reactnativemodule.fake

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.WritableMap
import java.util.concurrent.CountDownLatch

internal class FakePromise : Promise {

    var resolveValue: Any? = null
    var rejectThrowable: Throwable? = null

    private val lock = CountDownLatch(1)

    fun await() {
        lock.await()
    }

    override fun resolve(value: Any?) {
        resolveValue = value
        lock.countDown()
    }

    override fun reject(code: String?, message: String?) {
        rejectThrowable = RuntimeException("$code: $message")
        lock.countDown()
    }

    override fun reject(code: String?, throwable: Throwable?) {
        rejectThrowable = throwable ?: RuntimeException(code)
        lock.countDown()
    }

    override fun reject(code: String?, message: String?, throwable: Throwable?) {
        rejectThrowable = throwable ?: RuntimeException("$code: $message")
        lock.countDown()
    }

    override fun reject(code: String?, userInfo: WritableMap) {
        rejectThrowable = RuntimeException("$code: $userInfo")
        lock.countDown()
    }

    override fun reject(code: String?, throwable: Throwable?, userInfo: WritableMap) {
        rejectThrowable = throwable
        lock.countDown()
    }

    override fun reject(code: String?, message: String?, userInfo: WritableMap) {
        rejectThrowable = RuntimeException("$code: $message")
        lock.countDown()
    }

    override fun reject(code: String?, message: String?, throwable: Throwable?, userInfo: WritableMap?) {
        rejectThrowable = throwable ?: RuntimeException("$code: $message")
        lock.countDown()
    }

    @Deprecated("Use reject(code, message) instead")
    override fun reject(message: String) {
        rejectThrowable = RuntimeException(message)
        lock.countDown()
    }
}
