package com.usercentrics.reactnativesdk.sample

import android.app.Application
import com.facebook.react.ReactApplication
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.react.shell.MainReactPackage
import com.facebook.soloader.SoLoader
import com.reactnativecommunity.webview.RNCWebViewPackage
import com.usercentrics.reactnativeusercentrics.RNUsercentricsPackage
import com.swmansion.rnscreens.RNScreensPackage
import com.th3rdwave.safeareacontext.SafeAreaContextPackage
import java.util.*

class MainApplication : Application(), ReactApplication {

  private val mReactNativeHost = object : ReactNativeHost(this) {
    override fun getUseDeveloperSupport(): Boolean = true

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

  override val reactNativeHost: ReactNativeHost = mReactNativeHost

  override fun onCreate() {
    super.onCreate()
    SoLoader.init(this, false)
  }
}
