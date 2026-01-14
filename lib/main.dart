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
        body: TextFieldInForm(),
      ),
    );
  }
}

class TextFieldInForm extends StatefulWidget {
  const TextFieldInForm({super.key});

  @override
  State<TextFieldInForm> createState() => _TextFieldInFormState();
}

class _TextFieldInFormState extends State<TextFieldInForm> {
  String _textInput = "";
  final _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Input Your Name"),
              controller: _textController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.validate();
            },
            child: Text("Submit"),
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
