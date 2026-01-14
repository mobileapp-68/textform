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
        body: Form1(),
      ),
    );
  }
}

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  String _textInput = "";
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Input Your Name"),
            controller: textController,
            onChanged: (value) => {
              setState(() {
                _textInput = textController.text;
              }),
            },
          ),

          ElevatedButton(
            onPressed: () {
              textController.clear();
              setState(() {
                _textInput = "";
              });
            },
            child: Text("Clear"),
          ),
          Text("Input: $_textInput"),
        ],
      ),
    );
  }
}
