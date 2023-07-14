import 'package:flutter/material.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text("Practice your knowledge",
            style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Practice room'),
      ),
    );
  }
}
