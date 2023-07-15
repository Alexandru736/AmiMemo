import 'package:flutter/material.dart';

import 'flashcard.dart';

import 'flipCard.dart';

void main() {
  runApp(MaterialApp(
    title: 'Home Page',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Card'),
          onPressed: () {
            Flashcard flashCard = Flashcard(
              id: "1234",
              title: "Inima",
              description: "Anatomie",
              content:
                  "Inima este un organ muscular care pompează sângele prin corp",
              date: dateTime,
              correctWord: "organ",
              wrongWord1: "dwadawd",
              wrongWord2: "jucarie",
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FlipcardPage(flashCard: flashCard)));
          },
        ),
      ),
    );
  }
}
