import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'flashcard.dart';
import 'practicePage.dart';

class FlipcardPage extends StatefulWidget {
  final Flashcard flashCard;

  const FlipcardPage({Key? key, required this.flashCard}) : super(key: key);

  @override
  _FlipcardPageState createState() => _FlipcardPageState();
}

class _FlipcardPageState extends State<FlipcardPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          //title: const Text('Card with Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCard(
                title: widget.flashCard.title,
                description: widget.flashCard.description,
                content: widget.flashCard.content,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PracticePage(
                              flashcardList: [widget.flashCard],
                              correctAnswers: 0,
                              flashcardIndex: 0,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Practice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final String title;
  final String description;
  final String content;

  const MyCard({
    Key? key,
    required this.title,
    required this.description,
    required this.content,
  }) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _flipCard() {
    if (_controller.isAnimating) {
      // Animation is already running, do nothing
      return;
    }

    if (_controller.status != AnimationStatus.completed) {
      _controller.forward();
      setState(() {
        _isFront = !_isFront;
      });
    } else {
      _controller.reverse();
      setState(() {
        _isFront = !_isFront;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final front = Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.green,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final back = Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.green,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(math.pi),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.content,
                style: const TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              //const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: _flipCard,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: 350,
        height: 350.0,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(math.pi * _animation.value),
          alignment: Alignment.center,
          child: _isFront ? front : back,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
