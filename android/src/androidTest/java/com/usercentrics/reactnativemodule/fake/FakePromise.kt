package com.usercentrics.reactnativemodule.fake

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.WritableMap
import java.util.concurrent.CountDownLatch

internal class FakePromise : Promise {

    var resolveValue: Any? = null
    var rejectThrowable: Throwable? = null

    val lock = CountDownLatch(1)

    fun await() {
        lock.await()
    }

    override fun resolve(value: Any?) {
        this.resolveValue = value
        lock.countDown()
    }

    override fun reject(code: String?, message: String?) {
        TODO("Not yet implemented")
    }

    override fun reject(code: String?, throwable: Throwable?) {
        TODO("Not yet implemented")
    }

    override fun reject(code: String?, message: String?, throwable: Throwable?) {
        TODO("Not yet implemented")
    }

    override fun reject(throwable: Throwable?) {
        this.rejectThrowable = throwable
    }

    override fun reject(throwable: Throwable?, userInfo: WritableMap?) {
        TODO("Not yet implemented")
    }

    override fun reject(code: String?, userInfo: WritableMap) {
        TODO("Not yet implemented")
    }

    override fun reject(code: String?, throwable: Throwable?, userInfo: WritableMap?) {
        TODO("Not yet implemented")
    }

    override fun reject(code: String?, message: String?, userInfo: WritableMap) {
        TODO("Not yet implemented")
    }

    override fun reject(
        code: String?,
        message: String?,
        throwable: Throwable?,
        userInfo: WritableMap?
    ) {
        TODO("Not yet implemented")
    }

    override fun reject(message: String?) {
        TODO("Not yet implemented")
    }
}