import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String counterName;
  final int current;
  final VoidCallback onDelete;

  const Counter({
    super.key,
    required this.counterName,
    this.current = 0,
    required this.onDelete,
  });

  @override
  State<StatefulWidget> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late String counterName;
  late int current;

  @override
  void initState() {
    super.initState();
    counterName = widget.counterName;
    current = widget.current;
  }

  void increaseCurrent() {
    setState(() {
      current++;
    });
  }

  void decreaseCurrent() {
    setState(() {
      current--;
    });
  }

  void resetCounter() {
    setState(() {
      current = 0;
    });
  }

  void deleteCounter() {
    widget.onDelete();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.remove, color: Colors.black),
        onPressed: decreaseCurrent,
      ),
      title: Text(counterName, style: const TextStyle(color: Colors.black)),
      subtitle: Text(current.toString(), style: const TextStyle(color: Colors.black)),
      trailing: Container(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: increaseCurrent,
              ),
              IconButton(
                icon: const Icon(Icons.restart_alt, color: Colors.black),
                onPressed: resetCounter,
                tooltip: 'Reset This Counter',
              ),
              IconButton(
                onPressed: deleteCounter,
                tooltip: 'Delete This Counter',
                icon: const Icon(Icons.delete, color: Colors.black),
              ),
            ],
          ),  
        ),

      tileColor: Colors.purple[200],
    );
  }
}