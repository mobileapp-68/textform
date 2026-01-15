import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
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
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "firstname",
                  decoration: const InputDecoration(labelText: "Firstname"),
                  onChanged: (value) => setState(() {
                    _firstname = value ?? "";
                  }),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ]),
                ),
                FormBuilderTextField(
                  name: "lastname",
                  decoration: const InputDecoration(labelText: "Lastname"),
                  onChanged: (value) => setState(() {
                    _lastname = value ?? "";
                  }),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ]),
                ),
              ],
            ),
          ),

          Row(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                  if (_formKey.currentState?.isValid ?? false) {
                    // Print all form values
                    debugPrint(
                      "Firstname: ${_formKey.currentState?.fields["firstname"]?.value}",
                    );
                    debugPrint(
                      "Lastname: ${_formKey.currentState?.fields["lastname"]?.value}",
                    );
                  }
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
