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
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstname = "";
  String _lastname = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          Text(
            "Fullname: $_firstname $_lastname",
            style: TextStyle(fontSize: 24, fontWeight: .bold),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Firstname"),
                  onChanged: (value) => setState(() {
                    _firstname = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Lastname"),
                  onChanged: (value) => setState(() {
                    _lastname = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          Row(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                },
                child: Text("Submit"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _firstname = "";
                    _lastname = "";
                  });
                  _formKey.currentState?.reset();
                },
                child: Text("Clear"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
