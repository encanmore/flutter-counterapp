import 'package:flutter/material.dart';
import 'counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Counter Application'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _taskKey = GlobalKey<FormState>();
  TextEditingController counterNameController = TextEditingController();

  List<Counter> counters = [
    Counter(key: UniqueKey(), counterName: 'Beads', current: 0, onDelete: () {}),
    Counter(key: UniqueKey(), counterName: 'Cups of Water', current: 2, onDelete: () {}),
    Counter(key: UniqueKey(), counterName: 'Laps Run', current: 9, onDelete: () {})
  ];

  void _addCounter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 500,
          child: AlertDialog(
            scrollable: true,
            title: SizedBox(
              width: double.infinity, 
              height: 80,
              child: Text('Add New Counter', style: TextStyle(backgroundColor: Colors.purple[700], color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),), 
            ),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _taskKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: counterNameController,
                        decoration: const InputDecoration(
                          labelText: 'Counter Name',
                          icon: Icon(Icons.create),
                        ),
                      ),
                  ]),
                ),
            ),
            actions: [
              ElevatedButton(
                child: const Text("Create"),
                onPressed: () {
                  String title = counterNameController.text;
          
                  counterNameController.clear();
          
                  setState(() {
                    counters.add(Counter(key: UniqueKey(), counterName: title, onDelete: () => _deleteCounter(counters.length)));
                  });

                   Navigator.of(context).pop(); 
                })
            ],
          ),
        );
      }
    );
  }

  void _deleteCounter(int index) {
    setState(() {
      counters.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: const Text('Counter Application', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           children: counters.asMap().entries.map((entry) {
              int index = entry.key;
              Counter counter = entry.value;
              return Counter(
                key: counter.key,
                counterName: counter.counterName,
                current: counter.current,
                onDelete: () => _deleteCounter(index),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: _addCounter,
            tooltip: 'Add New Counter',
            child: const Icon(Icons.add),
          ),
      );
  }
}
