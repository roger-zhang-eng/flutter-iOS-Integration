import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mybatteryplugin/mybatteryplugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _mybatterypluginPlugin = Mybatteryplugin();

  num? _batteryLevel;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    getBatteryLevel();
  }

  Future<void> getBatteryLevel() async {
    num? batteryLevel;
    try {
      batteryLevel = await _mybatterypluginPlugin.getBatteryLevel();
    } on PlatformException {
      batteryLevel = null;
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _mybatterypluginPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Running on: $_platformVersion\n'),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _batteryLevel != null ? Text('Battery Level: $_batteryLevel')
                : const CircularProgressIndicator(),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('retrive battery level');
                    getBatteryLevel();
                  },
                child: const Text('Check battery level'),
                ),
              ),
            ],
          )
          
          //,
        ),
      ),
    );
  }
}
