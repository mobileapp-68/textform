import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

class MyForm extends HookWidget {
  MyForm({super.key});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final firstname = useState("");
    final lastname = useState("");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          Text(
            "Fullname: ${firstname.value} ${lastname.value}",
            style: TextStyle(fontSize: 24, fontWeight: .bold),
          ),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "firstname",
                  decoration: const InputDecoration(labelText: "Firstname"),
                  onChanged: (value) => firstname.value = value ?? "",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ]),
                ),
                FormBuilderTextField(
                  name: "lastname",
                  decoration: const InputDecoration(labelText: "Lastname"),
                  onChanged: (value) => lastname.value = value ?? "",
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
                  firstname.value = "";
                  lastname.value = "";
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
