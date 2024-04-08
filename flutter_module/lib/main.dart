import 'package:flutter/material.dart';
import 'Screens/route_screens.dart';

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
/*
void secondary() {
  runApp(
    MaterialApp(
      title: 'Second Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SecondScreen(),
    ),
  );
}
*/

/*
class MySecondAppScreen extends StatelessWidget {
    const MySecondAppScreen({Key? key}) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Second Screen Demo',
            theme: ThemeData(
                primarySwatch: Colors.green,
            ),
            
            home: const SecondScreen(),
        );
    }
}*/

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
            const Text(
              'New layout screen!',
            ),
          ],
        ),
      ),
    );
  }
}
