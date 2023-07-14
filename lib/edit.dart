import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Edit your flashcard",
            style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Edit'),
      ),
    );
  }
}
