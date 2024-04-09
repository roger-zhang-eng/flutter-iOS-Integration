import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  State<SecondScreen> createState() => _SecondScreen(isRouted);
}

class _SecondScreen extends State<SecondScreen> {
  _SecondScreen(this._isRouted);

  final bool _isRouted;
  final MethodChannel _platformChannel = const MethodChannel('app-channel');

  String _updatedText = 'Flutter Second Screen!';

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
    if (_isRouted) {
      Navigator.pop(context);
    } else {
      final String result =
          await _platformChannel.invokeMethod('dismissScreen');
      print('Result - $result \n');
      _updatedText = result;
      setState(() {});
    }
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
      child: Text('Fetch native data'),
    );

    ElevatedButton backButton = ElevatedButton(
      onPressed: () {
        dismissScreen(context);
      },
      child: const Text('Go back!'),
    );

    Padding padding = Padding(padding: EdgeInsets.all(8.0));

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
            _isRouted ? padding : fetchButton,
            padding,
            backButton,
          ],
        ),
      ),
    );
  }
}
