package com.usercentrics.reactnativemodule.fake

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.WritableMap

internal class FakePromise: Promise {

    var resolveValue: Any? = null
    var rejectThrowable: Throwable? = null

    override fun resolve(value: Any?) {
        this.resolveValue = value
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