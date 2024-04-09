import 'package:flutter/material.dart';
import 'Screens/route_screens.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Named Routes Demo",
      initialRoute: '/',
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
