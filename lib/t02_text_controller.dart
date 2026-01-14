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
        body: TextFieldWithController(),
      ),
    );
  }
}

class TextFieldWithController extends StatefulWidget {
  const TextFieldWithController({super.key});

  @override
  State<TextFieldWithController> createState() =>
      _TextFieldWithControllerState();
}

class _TextFieldWithControllerState extends State<TextFieldWithController> {
  String _textInput = "";
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _textInput = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Input Your Name"),
            controller: _textController,
          ),

          ElevatedButton(
            onPressed: () {
              _textController.clear();
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
