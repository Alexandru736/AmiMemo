import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Home Page',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Card'),
          onPressed: () {
            FlashCard flashCard = FlashCard('Title', 'Text', 'Content');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp(flashCard: flashCard)
                )
            );
          },
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  final FlashCard flashCard;

  const MyApp({Key? key, required this.flashCard}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class FlashCard {
  final String title;
  final String text;
  final String content;

  FlashCard(this.title, this.text, this.content);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card with Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCard(
                title: widget.flashCard.title,
                text: widget.flashCard.text,
                content: widget.flashCard.content,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                child: const Text('Next'),
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
  final String text;
  final String content;

  const MyCard({
    Key? key,
    required this.title,
    required this.text,
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
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _flipCard() {
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
        side: BorderSide(
          color: Colors.greenAccent,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.text,
              style: TextStyle(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    final back = Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.greenAccent,
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
                style: TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: _flipCard,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 200.0,
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