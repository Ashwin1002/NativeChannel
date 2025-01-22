import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/enable_screenshot.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/example/native_channel/ScreeshotAPI.g.kt',
    kotlinOptions: KotlinOptions(
      errorClassName: 'ScreeshotApiException',
    ),
    swiftOut: 'ios/Runner/ScreeshotAPI.g.swift',
    swiftOptions: SwiftOptions(
      errorClassName: 'ScreeshotApiException',
    ),
  ),
)
@HostApi()
abstract class ScreenshotApi {
  // enable screenshot
  bool enableScreenshot();

  // disable screenshot
  bool disableScreenshot();
}
