import 'package:flutter/material.dart';
import 'package:mybatteryplugin/mybatteryplugin.dart';
import 'dart:convert';

class ThirdScreen extends StatelessWidget {
  ThirdScreen({super.key});

  final Mybatteryplugin _batteryPlugin = Mybatteryplugin();

  void getAuthToken() async {
    final jsonString = await _batteryPlugin.getPlatformVersion();
    final tokenData = jsonDecode(jsonString!);
    final token = tokenData['authToken'];
    print('token: $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: ElevatedButton(
        onPressed: () {
          getAuthToken();
        },
        child: const Text('Get Auth Token'),
      ),
      ),
    );
  }
}