package com.usercentrics.reactnativesdk.example

import android.app.Application
import android.content.Context
import com.facebook.react.*
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint
import com.facebook.react.defaults.DefaultReactNativeHost
import com.facebook.soloader.SoLoader
import java.lang.reflect.InvocationTargetException

class MainApplication : Application(), ReactApplication {

    private val mReactNativeHost = object : DefaultReactNativeHost(this) {
        override fun getUseDeveloperSupport(): Boolean {
            return BuildConfig.DEBUG
        }

        override fun getPackages(): List<ReactPackage> {
            val packages = PackageList(this).packages
            return packages
        }

        override fun getJSMainModuleName(): String = "index"

        override val isNewArchEnabled: Boolean = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
        override val isHermesEnabled: Boolean = BuildConfig.IS_HERMES_ENABLED
    }

    override val reactNativeHost: ReactNativeHost
        get() = mReactNativeHost

    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, false)

        if (BuildConfig.IS_NEW_ARCHITECTURE_ENABLED) {
            DefaultNewArchitectureEntryPoint.load(
                true,
                true,
                false
            )
        }

        if (BuildConfig.DEBUG) {
            initializeFlipper(this, reactNativeHost.reactInstanceManager)
        }
    }

    companion object {

        private fun initializeFlipper(
            context: Context,
            reactInstanceManager: ReactInstanceManager
        ) {
            if (BuildConfig.DEBUG) {
                try {
                    val aClass = Class.forName("com.usercentrics.reactnativesdk.example.ReactNativeFlipper")
                    aClass
                        .getMethod(
                            "initializeFlipper",
                            Context::class.java,
                            ReactInstanceManager::class.java
                        )
                        .invoke(null, context, reactInstanceManager)
                } catch (e: ClassNotFoundException) {
                    e.printStackTrace()
                } catch (e: NoSuchMethodException) {
                    e.printStackTrace()
                } catch (e: IllegalAccessException) {
                    e.printStackTrace()
                } catch (e: InvocationTargetException) {
                    e.printStackTrace()
                }
            }
        }
    }
}
