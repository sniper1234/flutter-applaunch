# flutter_applaunch

A Flutter package that can retrive the URL Scheme parameters from app launch options.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

Example:

Map<dynamic, dynamic> scheme = await applaunchPlugin.getAppLaunchURLScheme();
setState(() {
    print("FlutterApplaunchPlugin -- App is launched by URL Scheme: $scheme");
});

the scheme contains 2 keys:
    - url: the url scheme that launch the app
    - source (optional): the scheme of source application which calls the scheme the app (if exists)
