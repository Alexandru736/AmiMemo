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
      body: Column(
        children: [
          const Text(
            'TITLU',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
          TextFormField(showCursor: true,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'DESCRIERE',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.green),
          ),
          TextFormField(
            decoration: const InputDecoration(),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'MATERIE',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
          TextFormField(),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'CONTENT',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
          TextFormField(),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'DATA',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green),
          ),
          TextFormField(),
          const SizedBox(
            height: 40,
          ),
          /*TextFormField(
    decoration: const InputDecoration(
    labelText: 'Field 6',
    ),
    ),
    TextFormField(
    decoration: const InputDecoration(
    labelText: 'Field 7',
    ),
    ),*/
        ],
      ),
    );
  }
}
