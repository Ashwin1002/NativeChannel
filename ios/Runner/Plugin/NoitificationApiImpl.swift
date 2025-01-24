//
//  NoitificationApiImpl.swift
//  Runner
//
//  Created by Ashwin Shrestha on 24/01/2025.
//

import UserNotifications

class NoitificationApiImpl: NotificationApi {
    
    func checkNotificationPermission()  -> NotificationPermissionStatus {
        let semaphore = DispatchSemaphore(value: 0) // Semaphore to block execution
            var permissionStatus: NotificationPermissionStatus = .notDetermined

            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    permissionStatus = .granted
                case .denied:
                    permissionStatus = .denied
                case .notDetermined:
                    permissionStatus = .notDetermined
                @unknown default:
                    permissionStatus = .notDetermined
                }
                semaphore.signal() // Signal to continue execution
            }

            semaphore.wait() // Wait until the completion handler finishes
            return permissionStatus
    }
    
    func requestPermission() throws -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
            var isGranted: Bool = false
            var permissionError: Error?

            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    isGranted = granted
                    permissionError = error
                    semaphore.signal()
            }

            semaphore.wait()

            if let error = permissionError {
                throw error
            }

            return isGranted
    }
    
    func triggerNotification(title: String, message: String) throws {
        let content = UNMutableNotificationContent()
                content.title = title
                content.body = message
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "test_notification_id", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
            }
    }
}
