library flutter_applaunch;

import 'dart:async';
import 'package:flutter/services.dart';

typedef Future<dynamic> EventHandler(Map<String, dynamic> event);

class FlutterApplaunchPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_applaunch');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///
  /// Get the RL Scheme from which the app is launched
  /// @param {Function} callback = (urlSchemeMap) => {}
  /// urlSchemeMap - a map object:
  ///   url: string, the url sheme being called
  ///   source: string, the app which calls the url sheme
  Future<Map<dynamic, dynamic>> getAppLaunchURLScheme() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('getAppLaunchURLScheme');
    return result;
  }
}
