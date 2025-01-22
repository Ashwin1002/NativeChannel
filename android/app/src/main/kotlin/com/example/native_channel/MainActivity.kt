package com.example.native_channel

import com.example.native_channel.plugin.DeviceInfoApiImpl
import com.example.native_channel.plugin.NotificationApiImpl
import com.example.native_channel.plugin.ScreenshotApiImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        DeviceInfoAPI.setUp(messenger, DeviceInfoApiImpl())

        ScreenshotApi.setUp(messenger, ScreenshotApiImpl(this.window))

        NotificationApi.setUp(flutterEngine.dartExecutor.binaryMessenger, NotificationApiImpl(this))
    }
}
