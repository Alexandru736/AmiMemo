import 'package:flutter/material.dart';
import 'package:mobile_catenav4/practice.dart';

import 'create.dart';
import 'edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorize Catena',
      theme: ThemeData(
        //this is the theme for the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MyHomePage(
        items: List<String>.generate(24, (i) => 'Item $i'),
        title: 'MEMORIZE CATENA',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<String> items;

  const MyHomePage({super.key, required this.title, required this.items});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //clasa de variabile
  ListTileTitleAlignment? titleAlignment;
  String alertext = '';
  String alertext2 = '';
  String viewflashcardtitle = 'Titlul Flashcardului de baza';
  String viewflashcardresponse =
      'A flashcard or flash card (also known as an index card) is a card bearing information on both sides, '
      'which is intended to be used as an aid in memorization. Each flashcard bears a question on one side and an answer on the other. '
      'Flashcards are often used to memorize vocabulary, historical dates, formulae or any subject matter that can be learned via a question-and-answer format. '
      'Flashcards can be virtual (part of a flashcard software), or physical.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Create new flashcard',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          prototypeItem: ListTile(
            title: Text(widget.items.first),
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                title:
                    const Text('Ce este viata?', textAlign: TextAlign.center),
                titleAlignment: ListTileTitleAlignment.center,
                horizontalTitleGap: 40,
                leading: const Icon(
                  Icons.heart_broken_rounded,
                  color: Colors.green,
                ),
                trailing: PopupMenuButton<ListTileTitleAlignment>(
                  onSelected: (ListTileTitleAlignment? value) {
                    setState(() {
                      if (value == ListTileTitleAlignment.center) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PracticePage()),
                        );
                      }
                      if (value == ListTileTitleAlignment.titleHeight) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditPage()),
                        );
                      }
                      titleAlignment = value;
                      switch (value) {
                        case ListTileTitleAlignment.threeLine:
                          alertext = '$index $viewflashcardtitle';
                          alertext2 = '$index $viewflashcardresponse';
                          break;
                        case ListTileTitleAlignment.titleHeight:
                          alertext = 'Edit';
                          alertext2 = 'Inca nimic';
                          break;
                        case ListTileTitleAlignment.top:
                          alertext = 'Delete';
                          alertext2 = 'Are you sure you want to delete?';
                          break;
                        case ListTileTitleAlignment.center:
                          //practice
                          break;
                        default:
                          // Handle the case where value is null
                          break;
                      }
                    });
                    if (value != ListTileTitleAlignment.center &&
                        value != ListTileTitleAlignment.titleHeight) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(alertext),
                            content: Text(alertext2),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.items.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK')),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<ListTileTitleAlignment>>[
                    const PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.threeLine,
                      child: Text('View'),
                    ),
                    const PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.titleHeight,
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.top,
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.center,
                      child: Text('Practice'),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePage()),
    );
  }
}
