package com.usercentrics.reactnativesdk.sample

import android.app.Application
import android.content.Context
import com.facebook.react.ReactApplication
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint
import com.facebook.react.shell.MainReactPackage
import com.facebook.soloader.SoLoader
import com.reactnativecommunity.webview.RNCWebViewPackage
import com.usercentrics.reactnative.RNUsercentricsPackage
import com.swmansion.rnscreens.RNScreensPackage
import com.th3rdwave.safeareacontext.SafeAreaContextPackage
import com.facebook.react.soloader.OpenSourceMergedSoMapping
import java.util.Arrays
import android.util.Log

class MainApplication : Application(), ReactApplication {

    private val mReactNativeHost: ReactNativeHost =
        object : ReactNativeHost(this) {
            override fun getUseDeveloperSupport(): Boolean = BuildConfig.DEBUG

            override fun getPackages(): List<ReactPackage> {
                return Arrays.asList(
                    MainReactPackage(),
                    RNUsercentricsPackage(),
                    RNCWebViewPackage(),
                    RNScreensPackage(),
                    SafeAreaContextPackage()
                )
            }

            override fun getJSMainModuleName(): String = "index"
        }

    override val reactNativeHost: ReactNativeHost
        get() = mReactNativeHost

    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, OpenSourceMergedSoMapping)

        Log.d("MainApplication", "IS_HERMES_ENABLED: ${BuildConfig.IS_HERMES_ENABLED}")
        Log.d("MainApplication", "IS_NEW_ARCHITECTURE_ENABLED: ${BuildConfig.IS_NEW_ARCHITECTURE_ENABLED}")
        Log.d("MainApplication", "DEBUG: ${BuildConfig.DEBUG}")

        if (BuildConfig.IS_NEW_ARCHITECTURE_ENABLED) {
            DefaultNewArchitectureEntryPoint.load()
        }
    }

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
    }
}
