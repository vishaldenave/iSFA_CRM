import 'package:flutter/services.dart';

class MyMethodChanel {
  static const MethodChannel _channel = MethodChannel('audio_recorder');

  static Future<bool> get hasPermissions async {
    bool hasPermission = await _channel.invokeMethod('hasPermissions');
    if (!hasPermission) {
      await requestPermission();
    }
    return hasPermission;
  }

  static Future<void> requestPermission() async {
    await _channel.invokeMethod('requestPermission');
  }

  static Future<bool> hasAssessability() async {
    bool hasAssessability = await _channel.invokeMethod("hasAccessibility");
    return hasAssessability;
  }

  static Future<void> start(String name, String phone) async {
    await _channel.invokeMethod("start", {"name": name, "phone": phone});
  }

  static Future<void> end() async {
    await _channel.invokeMethod("end");
  }
}
