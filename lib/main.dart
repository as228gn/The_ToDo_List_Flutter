import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor:  const Color.fromARGB(255, 39, 149, 176),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
         backgroundColor: const Color.fromARGB(255, 111, 137, 150),
        ),
        body: const ToDoList(),
      ),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _items = []; // Lista för att lagra objekten
  final TextEditingController _textController =
      TextEditingController(); // Controller för textfältet

  void _addItem() {
    setState(() {
      if (_textController.text.isNotEmpty) {
        _items.add(_textController
            .text); // Lägg till texten från textfältet till listan
        _textController.clear(); // Töm textfältet
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _textController.text =
          _items[index]; // Sätt textfältet till det borttagna objektet
      _items.removeAt(index); // Ta bort objektet från listan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Enter To Do',
                  ),
                ),
              ),
              FilledButton(
                onPressed: _addItem,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            thickness: 9.0,
            radius: const Radius.circular(10.0),
            child: ListView.builder(
              itemCount: _items.length, // Antal objekt i listan
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                  onTap: () => _removeItem(index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
