import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Set the delegate to handle notifications
        UNUserNotificationCenter.current().delegate = self
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let messenger: FlutterBinaryMessenger = controller.binaryMessenger
        
        DeviceInfoAPISetup.setUp(binaryMessenger: messenger, api: DeviceInfoApiImpl())
        ScreenshotApiSetup.setUp(binaryMessenger: messenger, api: ScreenshotApiImpl(window: window))
        NotificationApiSetup.setUp(binaryMessenger: messenger, api: NoitificationApiImpl())
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - UNUserNotificationCenterDelegate Methods
    
    /// Called when a notification is delivered while the app is in the foreground.
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show notification as a banner and play sound
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound])
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }
}
