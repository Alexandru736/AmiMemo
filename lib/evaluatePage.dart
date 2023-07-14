import 'package:flutter/material.dart';
import 'homepage.dart';
import 'flashcard.dart';
import 'practice.dart';

class EvaluatePage extends StatefulWidget {
  //const EvaluatePage({super.key});
  final List<Flashcard> flashcardList;
  final int flashcardIndex;
  final int correctAnswers;


  EvaluatePage({super.key, required this.flashcardList, required this.flashcardIndex, required this.correctAnswers});

  @override
  State<EvaluatePage> createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Evaluation'),
      ),
      body:
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("You got " + widget.correctAnswers.toString() + " correct answer(s) out of "+ widget.flashcardList.length.toString(),
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
    );

  }
}
