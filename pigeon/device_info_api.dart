import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/device_info.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/app/src/main/kotlin/com/example/native_channel/DeviceInfoApi.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Runner/DeviceInfoApi.g.swift',
  ),
)
class DeviceInfo {
  const DeviceInfo({
    required this.deviceName,
    required this.deviceModel,
    required this.deviceVersion,
    required this.deviceFamily,
  });

  final String deviceName;
  final String deviceModel;
  final String deviceVersion;
  final String deviceFamily;
}

@HostApi()
abstract class DeviceInfoAPI {
  // get device model information
  DeviceInfo getDeviceInfo();
}
