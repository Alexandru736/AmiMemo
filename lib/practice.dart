import 'flashcard.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'practicePage.dart';
import 'evaluatePage.dart';

class PracticeWidget extends StatefulWidget {
  final List<Flashcard> flashcardList;
  final int flashcardIndex;
  int correctAnswers = 0;

  PracticeWidget({super.key, required this.flashcardIndex, required this.flashcardList, required this.correctAnswers});


  @override
  State<PracticeWidget> createState() => _PracticeWidgetState();
}

class _PracticeWidgetState extends State<PracticeWidget> {
  String selectedWord = '';
  List<String> options = [];
  String content = '';
  late Flashcard flashcard;
  late int flashcardIndex;
  late List<Flashcard> flashcardList;
  //int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    flashcard = widget.flashcardList.elementAt(widget.flashcardIndex);
    flashcardIndex = widget.flashcardIndex;
    flashcardList = widget.flashcardList;
    options.add(flashcard.correctWord);
    options.add(flashcard.wrongWord1);
    options.add(flashcard.wrongWord2);
    options.shuffle();
    content = flashcard.content.replaceAll(flashcard.correctWord, '___');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            content,
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: selectedWord == '' ? () => wordReplace(options[0]) : null,
                child:Text(options[0]),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: selectedWord == '' ? () => wordReplace(options[1]) : null,
                child: Text(options[1]),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: selectedWord == '' ? () => wordReplace(options[2]) : null,
                child: Text(options[2]),
              ),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => checkAnswer(),
            child: Text('Check Answer'),
          ),
        ],
      ),
    );
  }

  void wordReplace(String buttonText) {
    setState(() {
      selectedWord = buttonText;
      content = content.replaceFirst('___', selectedWord);
    });
  }

  void checkAnswer() {
    if (selectedWord == '') {
      return;
    }
    String message;
    if (selectedWord == flashcard.correctWord) {
      message = 'Well done!';
      widget.correctAnswers++;
    } else {
      message = 'Wrong answer. The correct answer is: ${flashcard.correctWord}.';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  selectedWord = '';
                  content = flashcard.content.replaceFirst('___', '___');
                  options.shuffle(); // shuffle options again
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if(flashcardList.length <= 1) {
                          return MyHomePage();
                        }
                        if(flashcardIndex < flashcardList.length - 1) {
                          return PracticePage(flashcardList: flashcardList, flashcardIndex: flashcardIndex + 1 , correctAnswers: widget.correctAnswers,);   //
                        }
                        return EvaluatePage(flashcardList: flashcardList, flashcardIndex: flashcardIndex , correctAnswers: widget.correctAnswers); //TODO evaluationPage
                      }, // navigate back to StartPage
                    ),
                  );
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
