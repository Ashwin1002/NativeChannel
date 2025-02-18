import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:native_channel/src/device_info.g.dart';
import 'package:native_channel/src/enable_screenshot.g.dart';
import 'package:native_channel/src/notification_api.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Channel Demo with Pigeon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Native Channel Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DeviceInfo? _deviceInfo;
  @override
  void initState() {
    super.initState();

    ScreenshotApi().disableScreenshot();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() async {
    _deviceInfo = await DeviceInfoAPI().getDeviceInfo();

    final permissionStatus =
        await NotificationApi().checkNotificationPermission();

    log('staus => $permissionStatus');

    if (permissionStatus != NotificationPermissionStatus.granted) {
      await NotificationApi().requestPermission();
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(_deviceInfo?.deviceName ?? '-'),
          Text(_deviceInfo?.deviceFamily ?? '-'),
          Text(_deviceInfo?.deviceModel ?? '-'),
          Text(_deviceInfo?.deviceVersion ?? '-'),
          ElevatedButton(
            onPressed: () => NotificationApi().triggerNotification(
              'Hello',
              'This is a notification',
            ),
            child: Text('Trigger Notification'),
          )
        ],
      ),
    );
  }
}
