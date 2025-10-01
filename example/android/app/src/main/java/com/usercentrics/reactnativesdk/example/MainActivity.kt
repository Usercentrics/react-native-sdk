package com.usercentrics.reactnativesdk.example

import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultReactActivityDelegate

class MainActivity : ReactActivity() {

    override fun getMainComponentName(): String? = "usercentrics"

    override fun createReactActivityDelegate(): ReactActivityDelegate {
        return DefaultReactActivityDelegate(
            this,
            mainComponentName!!,
            BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
        )
    }
}
