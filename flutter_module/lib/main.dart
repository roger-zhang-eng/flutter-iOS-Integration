import 'package:flutter/material.dart';
import 'Screens/route_screens.dart';
import 'Module/route_observer.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Named Routes Demo",
      initialRoute: '/',
      navigatorObservers: [routeObserver],
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) =>
            const SecondScreen(title: "Flutter Screen", isRouted: true),
      },
    ),
  );
}

@pragma('vm:entry-point')
void secondary() => runApp(const MySecondAppScreen());

class MySecondAppScreen extends StatelessWidget {
  const MySecondAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var testApp = MaterialApp(
      title: 'Flutter Specific Entry Point!',
      theme: Theme.of(context).copyWith(
        extensions: [],
      ),
      home:
          const SecondScreen(title: "Specific Flutter Screen", isRouted: false),
    );

    return MaterialApp(
      title: 'Flutter Specific Entry Point!',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
          const SecondScreen(title: "Specific Flutter Screen", isRouted: false),
    );
  }
}
