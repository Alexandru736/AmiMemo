import 'package:flashcard_app/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:localstore/localstore.dart';

import 'entity/Flashcard.dart';

class CreateFlashcard extends StatefulWidget {
  @override
  _CreateFlashcardState createState() => _CreateFlashcardState();
}

class _CreateFlashcardState extends State<CreateFlashcard> {
  final db = Localstore.instance;
  String id = '-1';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final subjectController = TextEditingController();
  final contentController = TextEditingController();
  final correctAnswerController = TextEditingController();
  final firstWrongAnswerController = TextEditingController();
  final secondWrongAnswerController = TextEditingController();
  final thirdWrongAnswerController = TextEditingController();

  static const String flashcards = 'flashcards';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    subjectController.dispose();
    contentController.dispose();
    super.dispose();
  }

  String encodeData(List<dynamic> data) {
    return jsonEncode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        title: Text('Create flashcard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(

          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Titlu',
              ),
              controller: titleController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Descriere'),
              controller: descriptionController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Materie'),
              controller: subjectController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Continut'),
              controller: contentController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Raspuns corect'),
              controller: correctAnswerController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Raspuns gresit 1'),
              controller: firstWrongAnswerController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Raspuns gresit 2'),
              controller: secondWrongAnswerController,
            ),
            const SizedBox(height: 16.0),
            /*ElevatedButton(
                onPressed: () async {
                  final db = Localstore.instance;
                  final Map<String, dynamic>? flashcardMap =
                     await db.collection(flashcards).doc(id).get();
                  final flashcard = Flashcard.fromMap(flashcardMap);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(flashcard.title),
                      content: Column(
                        children: [
                          Text(flashcard.description),
                          Text(flashcard.content),
                          Text(flashcard.correctWordIndex)
                        ],
                      ),
                    ),
                  );
                },
                child: Text('Retrieve')),*/
            FloatingActionButton(
                mini: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                backgroundColor: Colors.green,
                onPressed: () {
                  final db = Localstore.instance;
                  final id =
                      Localstore.instance.collection(flashcards).doc().id;
                  this.id = id;
                  final DateTime date = DateTime.now();
                  final String content = contentController.text;
                  final String correctAnswer = correctAnswerController.text;

                  final List<String> words = content.split(' ');
                  final int index = words.indexOf(correctAnswer);

                  final String correctWordIndex = index.toString();

                  final Flashcard flashcard = Flashcard(
                      id,
                      titleController.text,
                      descriptionController.text,
                      contentController.text,
                      date,
                      correctAnswerController.text,
                      firstWrongAnswerController.text,
                      secondWrongAnswerController.text,
                      correctWordIndex
                  );
                  db.collection(flashcards).doc(id).set(flashcard.toMap());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()),
                  );
                },
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}