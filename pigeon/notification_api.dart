import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/notification_api.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/example/native_channel/NotificationApi.g.kt',
    kotlinOptions: KotlinOptions(
      errorClassName: 'NotificationApiException',
    ),
    swiftOut: 'ios/Runner/NotificationApi.g.swift',
    swiftOptions: SwiftOptions(
      errorClassName: 'NotificationApiException',
    ),
  ),
)
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
