import 'package:flutter/material.dart';
import 'homepage.dart';
import 'flashcard.dart';
import 'practice.dart';

class PracticePage extends StatefulWidget {
  final List<Flashcard> flashcardList;
  final int flashcardIndex;
  int correctAnswers = 0;
  PracticePage({Key? key, required this.flashcardList, required this.flashcardIndex, required this.correctAnswers}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Practice!'),
      ),
      body: PracticeWidget(flashcardList: widget.flashcardList, flashcardIndex: widget.flashcardIndex, correctAnswers: widget.correctAnswers),
    );
  }
}

