package com.example.native_channel.plugin


import ScreenshotApi
import android.view.Window
import android.view.WindowManager


class ScreenshotApiImpl(private val window: Window?) : ScreenshotApi {
    override fun enableScreenshot(): Boolean {
        window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        return  true
    }

    override fun disableScreenshot(): Boolean {
        window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        return  false
    }
}