package com.example.native_channel

import com.example.native_channel.plugin.DeviceInfoApiImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        DeviceInfoAPI.setUp(flutterEngine.dartExecutor.binaryMessenger, DeviceInfoApiImpl())
    }
}
