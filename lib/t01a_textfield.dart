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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          Text("Fullname:", style: TextStyle(fontSize: 24, fontWeight: .bold)),
          TextField(decoration: const InputDecoration(labelText: "Firstname")),
          TextField(decoration: const InputDecoration(labelText: "Lastname")),
          Row(
            spacing: 10,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Submit")),
              ElevatedButton(onPressed: () {}, child: Text("Clear")),
            ],
          ),
        ],
      ),
    );
  }
}
