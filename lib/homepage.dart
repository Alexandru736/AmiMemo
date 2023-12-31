import 'package:flashcard_app/createFlashcard.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'flashcard.dart';
import 'flipCard.dart';
import 'edit.dart';
import 'practicePage.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  final Localstore db = Localstore.instance;

  // List<Flashcard> flashcardList = [
  //   Flashcard(
  //     id: "1234",
  //     title: "Inima",
  //     description: "Anatomie",
  //     content: "Inima este un organ muscular care pompează sângele prin corp",
  //     date: DateTime.now(),
  //     correctWord: "organ",
  //     wrongWord1: "dwadawd",
  //     wrongWord2: "jucarie",
  //   ),
  //   Flashcard(
  //     id: "1234",
  //     title: "Inima",
  //     description: "Anatomie",
  //     content: "Inima este un organ muscular care pompează sângele prin corp",
  //     date: DateTime.now(),
  //     correctWord: "organ",
  //     wrongWord1: "dwadawd",
  //     wrongWord2: "jucarie",
  //   ),
  //   Flashcard(
  //     id: "1234",
  //     title: "Inima",
  //     description: "Anatomie",
  //     content: "Inima este un organ muscular care pompează sângele prin corp",
  //     date: DateTime.now(),
  //     correctWord: "organ",
  //     wrongWord1: "dwadawd",
  //     wrongWord2: "jucarie",
  //   ),
  // ];

  List<Flashcard> flashcardList = [];

  @override
  void initState() {
    db.collection('flashcards').get().then((value) {
      setState(() {
        value?.entries.forEach((element) {
          final flashcard = Flashcard.fromMap(element.value);
          flashcardList.add(flashcard);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Create new flashcard',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                if(flashcardList.isNotEmpty) {
                  return PracticePage(
                    flashcardList: flashcardList,
                    flashcardIndex: 0,
                    correctAnswers: 0,
                  );
                }
                return const MyHomePage();
              }),
            );
          },
          icon: const Icon(Icons.school_rounded),
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('MEMORIZE CATENA',
            style: const TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
          itemCount: flashcardList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                title: Text(flashcardList.elementAt(index).title,
                    textAlign: TextAlign.center),
                titleAlignment: ListTileTitleAlignment.center,
                horizontalTitleGap: 40,
                leading: const Icon(
                  Icons.heart_broken_rounded,
                  color: Colors.green,
                ),
                trailing: PopupMenuButton<ListTileTitleAlignment>(
                  onSelected: (ListTileTitleAlignment? value) {
                    if (value == ListTileTitleAlignment.center) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlipcardPage(
                            flashCard: flashcardList.elementAt(index),
                          ),
                        ),
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
                        alertext = flashcardList.elementAt(index).title;
                        alertext2 = flashcardList.elementAt(index).content;
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
                                    Navigator.of(context).pop();
                                    setState(() {});
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
                    PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.top,
                      onTap: () => deleteFlashcard(index),
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
      MaterialPageRoute(builder: (context) => CreateFlashcard()),
    );
  }

  void deleteFlashcard(int index) {
    final String id = flashcardList.elementAt(index).id;
    flashcardList.removeAt(index);
    db.collection('flashcards').doc(id).delete();
  }
}
