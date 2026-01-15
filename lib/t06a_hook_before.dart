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
  String _textFirstName = "";
  String _textLastName = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ! Need two controllers for two text fields
  final _textControllerFirstName = TextEditingController();
  final _textControllerLastName = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ! Need to add listeners for both controllers
    _textControllerFirstName.addListener(() {
      setState(() {
        _textFirstName = _textControllerFirstName.text;
      });
    });
    _textControllerLastName.addListener(() {
      setState(() {
        _textLastName = _textControllerLastName.text;
      });
    });
  }

  @override
  void dispose() {
    // ! Need to dispose both controllers
    _textControllerFirstName.dispose();
    _textControllerLastName.dispose();
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
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Firstname"),
                  controller: _textControllerFirstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a firstname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Lastname"),
                  controller: _textControllerLastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a lastname';
                    }
                    return null;
                  },
                ),
              ],
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
              _textControllerFirstName.clear();
              _textControllerLastName.clear();
            },
            child: Text("Clear"),
          ),
          Text("Fullname: $_textFirstName $_textLastName"),
        ],
      ),
    );
  }
}
