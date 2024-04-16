import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybatteryplugin/mybatteryplugin.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen when tapped.
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    super.key,
    required this.title,
    required this.isRouted,
  });

  final String title;
  final bool isRouted;

  @override
  State<SecondScreen> createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  final MethodChannel _platformChannel = const MethodChannel('app-channel');
  final Mybatteryplugin _batteryPlugin = Mybatteryplugin();

  String _updatedText = 'Flutter Second Screen!';
  String _batteryLevel = 'Check Battery - Unknown level.';

  void fetchDataFromNative() async {
    try {
      final String result =
          await _platformChannel.invokeMethod('getDataFromNative');
      print('\nResult from Native: $result');
      _updatedText = result;
      setState(() {});
    } on PlatformException catch (e) {
      print('\nError: ${e.message}');
    }
  }

  void dismissScreen(BuildContext context) async {
    if (widget.isRouted) {
      Navigator.pop(context);
    } else {
      final String result =
          await _platformChannel.invokeMethod('dismissScreen');
      print('Result - $result \n');
      _updatedText = result;
      setState(() {});
    }
  }

  void getBatteryLevel() async {
    final batteryLevel = await _batteryPlugin.getBatteryLevel();
    print('Battery Level: $batteryLevel');
    setState(() {
      _batteryLevel = 'Check Battery - $batteryLevel%';
    });
  }

  @override
  void dispose() {
    print('Second Screen is disposed! \n');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ElevatedButton fetchButton = ElevatedButton(
      onPressed: () {
        print('Fetch button is tapped! \n');
        fetchDataFromNative();
      },
      child: const Text('Fetch native data'),
    );

    Padding backButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          dismissScreen(context);
        },
        child: const Text('Go back!'),
      ),
    );

    Padding padding = const Padding(padding: EdgeInsets.all(8.0));

    Padding checkBatteryButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          getBatteryLevel();
        },
        child: Text(_batteryLevel),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_updatedText),
            const Padding(padding: EdgeInsets.all(8.0)),
            widget.isRouted ? padding : fetchButton,
            padding,
            checkBatteryButton,
            backButton,
          ],
        ),
      ),
    );
  }
}
