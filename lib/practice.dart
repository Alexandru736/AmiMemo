import 'package:flutter/material.dart';
import 'homepage.dart';
import 'flashcard.dart';

class PracticePage extends StatefulWidget {
  final Flashcard flashcard;

  PracticePage({Key? key, required this.flashcard}) : super(key: key);

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  String selectedWord = '';
  List<String> options = [];
  String content = '';


  @override
  void initState() {
    super.initState();
    options.add(widget.flashcard.correctWord);
    options.add(widget.flashcard.wrongWord1);
    options.add(widget.flashcard.wrongWord2);
    options.shuffle();
    content = widget.flashcard.content.replaceAll(widget.flashcard.correctWord, '___');
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
    if (selectedWord == widget.flashcard.correctWord) {
      message = 'Well done!';
    } else {
      message = 'Wrong answer. The correct answer is: ${widget.flashcard.correctWord}.';
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
                  content = widget.flashcard.content.replaceFirst('___', '___');
                  options.shuffle(); // shuffle options again
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartPage(), // navigate back to StartPage
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Practice!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              content,
              style: TextStyle(fontSize: 30, color: Colors.deepPurple),
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
      ),
    );
  }
}

class NextWord extends StatelessWidget {
  const NextWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Next Word'),
      ),
      body: Center(
        child: Text(
          'Let\'s move on to the next word.',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

