import 'package:flutter/material.dart';
import 'flashcard.dart';
import 'practicePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
  DateTime date2 = DateTime.now();

  List<Flashcard> flashcardList = [
    Flashcard(
      "124",
      "Creierul",
      "Anatomie",
      "Creierul reprezintă partea sistemului nervos central aflată în interiorul craniului.",
      DateTime.now(),
      "central",
      "stang",
      "drept",
    ),
    Flashcard(
      "125",
      "Piciorul",
      "Anatomie",
      "Piciorul este o structură biologică aflată la extremitatea membrelor inferioare care se găsește la multe animale.",
      DateTime.now(),
      "membrelor",
      "mainilor",
      "bazelor",
    ),
  ]; //

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
                flashcardList: flashcardList,
                flashcardIndex: 0,
                correctAnswers: 0,
              ),
            ),
          );
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
