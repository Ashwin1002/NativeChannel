//
//  ScreenshotApiImpl.swift
//  Runner
//
//  Created by Ashwin Shrestha on 24/01/2025.
//
import ScreenProtectorKit

class ScreenshotApiImpl: ScreenshotApi {
    
    private let window: UIWindow?
    
    init (window: UIWindow?) {
        self.window = window
    }
    
    private lazy var screenProtectorKit = { return ScreenProtectorKit(window: window) }()
    
    func enableScreenshot() throws -> Bool {
        screenProtectorKit.enabledBlurScreen()
        return true
    }
    
    func disableScreenshot() throws -> Bool {
        screenProtectorKit.disableBlurScreen()
        return false
    }
}
