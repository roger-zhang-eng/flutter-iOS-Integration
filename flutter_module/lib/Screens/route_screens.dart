import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/Screens/thirdScreen.dart';
import 'package:mybatteryplugin/mybatteryplugin.dart';
import '../Module/route_observer.dart';
import 'bottom_sheet.dart';
import 'contentList.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as MBS;
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now the topmost route.
    print('RZ: didPush');
  }

  @override
  void didPushNext() {
    print("RZ: didPushNext");
    super.didPushNext();
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print('RZ: didPopNext');
  }

  @override
  void didPop() {
    print("RZ: didPop");
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Screen'),
        ),
        body: Center(
            // ignore: avoid_unnecessary_containers
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 32.0),
            const Text('First Screen'),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen when tapped.
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Launch screen'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                openBottomSheet(context, const MyBottomSheet(), false);
              },
              child: const Text('Modal Bottom Sheet'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                openBottomPermToast();
                //openBottomSheet(context, const ContentList(), true);
              },
              child: const Text('Bottom perm toast'),
            ),
            const SizedBox(height: 32.0),
          ],
        )));
  }

  void openBottomSheet(
      BuildContext context, Widget screen, bool enableDraggable) {
    MBS.showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) => screen,
      enableDrag: enableDraggable,
    );
  }

  void openBottomPermToast() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height *
                  0.9, // Maximum height of the bottom sheet
            ),
            child: const ContentList(),
          );
        });
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
  String _authToken = 'dummy-auth-token';
  late FToast _fToast;

  @override
  void initState() {
    super.initState();

    _fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    _fToast.init(context);
  }

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

  void getAuthToken() async {
    final jsonString = await _batteryPlugin.getPlatformVersion();
    final tokenData = jsonDecode(jsonString!);
    print('token: $tokenData');
    final token = tokenData['authToken'];
    setState(() {
      _authToken = 'From native token - $token';
    });
  }

  @override
  void dispose() {
    //print('Second Screen is disposed! \n');
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

    Padding checkTokenButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          getAuthToken();
        },
        child: Text(_authToken),
      ),
    );

    Padding pushNextScreenButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        child: const Text('Push the 3rd Screen'),
      ),
    );

    Padding displayToast = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _showToast();
        },
        child: const Text('Display Toast'),
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
            checkTokenButton,
            displayToast,
            widget.isRouted ? padding : pushNextScreenButton,
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ThirdScreen()));
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    _fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }
}
