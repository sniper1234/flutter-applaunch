import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_applaunch/flutter_applaunch.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String _platformVersion = 'Unknown';
  Map<dynamic, dynamic> _launchScheme;
  final FlutterApplaunchPlugin applaunchPlugin = new FlutterApplaunchPlugin();

  int appState = 0;
  int index = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterApplaunchPlugin.platformVersion;
    } on Exception {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    Map<dynamic, dynamic> scheme =
        await applaunchPlugin.getAppLaunchURLScheme();

    setState(() {
      _platformVersion = platformVersion;
      _launchScheme = scheme;
      print("FlutterApplaunchPlugin -- platformVersion: $_platformVersion");
      print(
          "FlutterApplaunchPlugin -- App is launched by URL Scheme: $_launchScheme");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Text('Running on: $_platformVersion\nStarted URL: $_launchScheme'),
            Text(appState == 0 ? "onreume" + index.toString() : "onpause")
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _lastLifecyleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecyleState = state;
    if (state == AppLifecycleState.resumed) {
      appState = 0;
      index++;
    } else {
      appState = 1;
    }

    initPlatformState();
    print(
            'The most recent lifecycle state this widget observed was: $_lastLifecyleState.');
  }
}
