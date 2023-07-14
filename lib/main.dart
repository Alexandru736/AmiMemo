import 'package:flutter/material.dart';

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

  // This widget is the home page of your application. It is stateful
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //clasa de variabile
  ListTileTitleAlignment? titleAlignment;

  //int _counter = 0;

  void _nextPage() {
    setState(() {
      //pentru a da refresh
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values.
      //se duce la o alta pagina
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Create new flashcard',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
                //title: const Text('Ce este viata?', textAlign: TextAlign.center),
                trailing: PopupMenuButton<ListTileTitleAlignment>(
                  onSelected: (ListTileTitleAlignment? value) {
                    setState(() {
                      titleAlignment = value;
                    });
                    showDialog(context: context, builder: (BuildContext context)
                    {
                      return AlertDialog(
                        title: const Text('Mytitle'),
                        content: const Text('This is a message'),
                        actions: [
                          TextButton(onPressed: (){}, child: const Text('OK')),
                        ],
                      );
                    },);
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
}
