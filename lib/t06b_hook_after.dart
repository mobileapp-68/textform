import 'package:flutter/material.dart';
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
        body: TextFieldInForm(),
      ),
    );
  }
}

class TextFieldInForm extends HookWidget {
  TextFieldInForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textControllerFirstName = useTextEditingController();
    final textControllerLastName = useTextEditingController();
    final textFirstName = useState("");
    final textLastName = useState("");

    useEffect(() {
      void updateFirstName() {
        textFirstName.value = textControllerFirstName.text;
      }

      void updateLastName() {
        textLastName.value = textControllerLastName.text;
      }

      textControllerFirstName.addListener(updateFirstName);
      textControllerLastName.addListener(updateLastName);

      return () {
        textControllerFirstName.removeListener(updateFirstName);
        textControllerLastName.removeListener(updateLastName);
      };
    }, []);

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
                  controller: textControllerFirstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a firstname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Lastname"),
                  controller: textControllerLastName,
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
              textControllerFirstName.clear();
              textControllerLastName.clear();
            },
            child: Text("Clear"),
          ),
          Text("Fullname: ${textFirstName.value} ${textLastName.value}"),
        ],
      ),
    );
  }
}
