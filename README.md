# NativeChannel

A project demonstrating how to use the **Pigeon** package to create seamless communication bridges between Flutter and native platforms (Swift for iOS and Kotlin for Android).

---

## Getting Started

This guide explains how to set up, clone, and run the project, along with instructions for using the **Pigeon** package.

---

## Prerequisites

Ensure the following are installed on your system:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Android Studio** or **Xcode** for native development:
  - **Android**: Java/Kotlin setup with an emulator or a connected physical device.
  - **iOS**: Xcode and a valid Apple Developer account (if testing on a physical device).
- **Dart**: Ensure Dart is configured as part of your Flutter setup.

---

## Setup and Installation

### Clone the Repository

```bash
git clone https://github.com/Ashwin1002/NativeChannel.git
cd NativeChannel
```

### Install Dependencies

If `pigeon` is not installed then install from your terminal by using:

```bash
dart pub add pigeon
```

or

```
dependencies:
  pigeon: ^22.7.4
```

### Generate Pigeon Code

Create a folder `pigeon` outside of your lib folder. Create a file `messages.dart`.
Configure pigeon as below:

```dart
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/example/native_channel/Messages.g.kt',
    kotlinOptions: KotlinOptions(
      errorClassName: 'MessageException',
    ),
    swiftOut: 'ios/Runner/Messages.g.swift',
    swiftOptions: SwiftOptions(
      errorClassName: 'MessageException',
    ),
  ),
)
```

```bash
dart run pigeon --input pigeon/messages.dart
```

- Replace `messages.dart` with your Pigeon schema file if needed.
- Output files will be generated for Dart, Kotlin, and Swift.

### Run the App

- **For Android**:
  ```bash
  flutter run -d android
  ```
- **For iOS**:
  ```bash
  flutter run -d ios
  ```

---

## Using the Pigeon Package

Pigeon bridges Flutter with native platforms via method calls. Here’s how it works:

### 1. Define APIs in a Dart File

Create a schema in a `.dart` file for your APIs. For example:

```dart
import 'package:pigeon/pigeon.dart';

enum NotificationPermissionStatus {
  granted,
  denied,
  notDetermined,
}

@HostApi()
abstract class NotificationApi {
  NotificationPermissionStatus checkNotificationPermission();
  bool requestPermission();
  void triggerNotification(String title, String message);
}
```

### 2. Generate Code

Run the Pigeon generation command (as explained earlier). This will create:

- A Dart API in `lib/native_channel.dart`.
- Platform-specific APIs in Kotlin and Swift for Android and iOS.

### 3. Implement Native Code

In your Kotlin or Swift files, implement the methods defined in the Dart schema.

#### Kotlin Example

```kotlin
class NotificationApiImpl : NotificationApi {
    override fun checkNotificationPermission(): NotificationPermissionStatus { ... }
    override fun requestPermission(): Boolean { ... }
    override fun triggerNotification(title: String, message: String) { ... }
}
```

#### Swift Example

```swift
class NotificationApiImpl: NotificationApi {
    func checkNotificationPermission() -> NotificationPermissionStatus { ... }
    func requestPermission() -> Bool { ... }
    func triggerNotification(title: String, message: String) { ... }
}
```

### 4. Connect the APIs to Flutter

Use the `setup` function in the generated code to connect Flutter and native APIs.

#### Example (AppDelegate for iOS)

```swift
NotificationApiSetup.setUp(binaryMessenger: messenger, api: NotificationApiImpl())
```

---

## Features Demonstrated in This Project

- Bridging communication between Flutter and native platforms using Pigeon.
- Using platform-specific features like notifications, disable screenshots and device information retrieval.
- Simplified and type-safe communication.

---

## Troubleshooting

- If you encounter any errors related to code generation, ensure you’ve defined the correct Pigeon schema and installed the required dependencies.
- Ensure the app has the necessary permissions to run platform-specific features like notifications.

---

## Resources

- [Pigeon Documentation](https://pub.dev/packages/pigeon)
- [Flutter Documentation](https://flutter.dev/docs)

---
