package com.example.native_channel.plugin

import DeviceInfo
import DeviceInfoAPI

import android.os.Build


class DeviceInfoApiImpl : DeviceInfoAPI {
    override fun getDeviceInfo(): DeviceInfo {

        val deviceName: String = Build.MODEL
        val deviceManufacturer: String = Build.MANUFACTURER
        val deviceVersion: String = Build.VERSION.RELEASE
        val deviceFamily: String = Build.DEVICE

        return DeviceInfo(
            deviceFamily = deviceFamily,
            deviceName = deviceName,
            deviceVersion = deviceVersion,
            deviceModel = deviceManufacturer,
        )
    }

}