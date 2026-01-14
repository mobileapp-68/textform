import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Text Form")),
        body: SimpleTextField(),
      ),
    );
  }
}

class SimpleTextField extends StatefulWidget {
  const SimpleTextField({super.key});

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  String _textInput = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Input Your Name"),
            onChanged: (value) => {
              setState(() {
                _textInput = value;
              }),
            },
          ),
          Text("Input: $_textInput"),
        ],
      ),
    );
  }
}
