package com.usercentrics.reactnativesdk.example

import android.content.Context
import com.facebook.flipper.android.AndroidFlipperClient
import com.facebook.flipper.android.utils.FlipperUtils
import com.facebook.flipper.core.FlipperClient
import com.facebook.flipper.plugins.crashreporter.CrashReporterPlugin
import com.facebook.flipper.plugins.databases.DatabasesFlipperPlugin
import com.facebook.flipper.plugins.inspector.DescriptorMapping
import com.facebook.flipper.plugins.inspector.InspectorFlipperPlugin
import com.facebook.flipper.plugins.network.FlipperOkhttpInterceptor
import com.facebook.flipper.plugins.network.NetworkFlipperPlugin
import com.facebook.flipper.plugins.react.ReactFlipperPlugin
import com.facebook.flipper.plugins.sharedpreferences.SharedPreferencesFlipperPlugin
import com.facebook.react.ReactInstanceManager
import com.facebook.react.modules.network.NetworkingModule
import okhttp3.OkHttpClient

object ReactNativeFlipper {
    fun initializeFlipper(context: Context, reactInstanceManager: ReactInstanceManager) {
        if (BuildConfig.DEBUG && FlipperUtils.shouldEnableFlipper(context)) {
            val client: FlipperClient = AndroidFlipperClient.getInstance(context)
            client.addPlugin(InspectorFlipperPlugin(context, DescriptorMapping.withDefaults()))
            client.addPlugin(ReactFlipperPlugin())
            client.addPlugin(DatabasesFlipperPlugin(context))
            client.addPlugin(SharedPreferencesFlipperPlugin(context))
            client.addPlugin(CrashReporterPlugin.getInstance())
            val networkPlugin = NetworkFlipperPlugin()
            NetworkingModule.setCustomClientBuilder { builder: OkHttpClient.Builder ->
                builder.addNetworkInterceptor(FlipperOkhttpInterceptor(networkPlugin))
            }
            client.addPlugin(networkPlugin)
            client.start()
        }
    }
}
