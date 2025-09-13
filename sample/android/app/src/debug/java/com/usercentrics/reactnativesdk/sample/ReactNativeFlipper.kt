package com.usercentrics.reactnativesdk.sample

import android.content.Context
import com.facebook.flipper.android.AndroidFlipperClient
import com.facebook.flipper.android.utils.FlipperUtils
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

object ReactNativeFlipper {
    @JvmStatic
    fun initializeFlipper(context: Context?, reactInstanceManager: ReactInstanceManager) {
        if (FlipperUtils.shouldEnableFlipper(context)) {
            val client = AndroidFlipperClient.getInstance(context)
            client.addPlugin(InspectorFlipperPlugin(context, DescriptorMapping.withDefaults()))
            client.addPlugin(ReactFlipperPlugin())
            client.addPlugin(DatabasesFlipperPlugin(context))
            client.addPlugin(SharedPreferencesFlipperPlugin(context))
            client.addPlugin(CrashReporterPlugin.getInstance())
            val networkFlipperPlugin = NetworkFlipperPlugin()
            NetworkingModule.setCustomClientBuilder { builder ->
                builder.addNetworkInterceptor(FlipperOkhttpInterceptor(networkFlipperPlugin))
            }
            client.addPlugin(networkFlipperPlugin)
            
            client.start()
        }
    }
}
