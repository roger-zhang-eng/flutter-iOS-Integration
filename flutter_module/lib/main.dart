import 'package:flutter/material.dart';
import 'Screens/route_screens.dart';
import 'package:flutter/services.dart';

//void main() => runApp(const MyApp());

void main() {
  runApp(
    MaterialApp(
      title: "Named Routes Demo",
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
      },
    ),
  );
}

@pragma('vm:entry-point')
void secondary() => runApp(const MySecondAppScreen());

class MySecondAppScreen extends StatelessWidget {
  const MySecondAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MySecondaryHomePage(title: 'Flutter Demo New Entrypoint!'),
    );
  }
}

class MySecondaryHomePage extends StatefulWidget {
  const MySecondaryHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MySecondaryHomePage> createState() => _MySecondaryHomePageState();
}

class _MySecondaryHomePageState extends State<MySecondaryHomePage> {
  final MethodChannel platformChannel = const MethodChannel('app-channel');

  String _updatedText = 'Flutter Screen!';

  void fetchDataFromNative() async {
    try {
      final String result = await platformChannel.invokeMethod('getDataFromNative');
      print('\nResult from Native: $result');
      _updatedText = result;
      setState(() {});
    } on PlatformException catch (e) {
      print('\nError: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_updatedText),

            Padding(padding: EdgeInsets.all(8.0)),

            ElevatedButton(
                onPressed: () {
                  print('Fetch native data');
                  fetchDataFromNative();
                },
                child: Text('Fetch native data')
            ),
          ],
        ),
      ),
    );
  }
}
