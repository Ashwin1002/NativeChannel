//
//  DeviceInfoApiImpl.swift
//  Runner
//
//  Created by Ashwin Shrestha on 24/01/2025.
//
import UIKit

class DeviceInfoApiImpl : DeviceInfoAPI {
    
     func getDeviceInfo() -> DeviceInfo {
        let device = UIDevice.current
        let deviceInfo: DeviceInfo = DeviceInfo(
            deviceName: device.name,
            deviceModel: device.model,
            deviceVersion: device.systemVersion,
            deviceFamily: "iOS"
        )
         print("Device Info: \(deviceInfo)")
        return deviceInfo
      }
}
