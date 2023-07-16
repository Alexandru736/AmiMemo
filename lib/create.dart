import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Create a new flashcard",
            style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('This is the new page'),
      ),
    );
  }
}