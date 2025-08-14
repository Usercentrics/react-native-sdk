package com.example

import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultReactActivityDelegate

class MainActivity : ReactActivity() {

    override fun getMainComponentName(): String? = "example"

    override fun createReactActivityDelegate(): ReactActivityDelegate {
        // Fabrica o ReactActivityDelegate correto com Fabric e Concurrent Root
        return DefaultReactActivityDelegate(
            this,
            mainComponentName!!,
            BuildConfig.IS_NEW_ARCHITECTURE_ENABLED // Usado para ambos Fabric e Concurrent React
        )
    }
}
