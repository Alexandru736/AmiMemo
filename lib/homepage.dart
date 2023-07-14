import 'package:flutter/material.dart';
import 'flashcard.dart';
import 'practice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartPage(),
    );
  }
}


class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the Practice App!'),
      ),
      body: Center(
        child: Text(
          'Press the button to start practicing!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PracticePage(
                flashcard: Flashcard(
                  "123",
                  "Inima",
                  "Un organ",
                  "Inima este un organ muscular care pompează sângele prin corp",
                  date,
                  "organ",
                  "jucarie",
                  "obiect",
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}