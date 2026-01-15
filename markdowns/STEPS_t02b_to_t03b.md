# Steps to Transform t02b_text_controller.dart to t03b_form.dart

## Overview

This guide walks through refactoring from TextEditingController-based input to Flutter's Form widget with TextFormField for better form validation and state management.

---

## Step 1: Replace TextEditingController with Form Key

**Location:** In the `_MyFormState` class, replace the controller declarations

Remove the TextEditingController instances and add a GlobalKey for form validation:

```dart
// Before:
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
String _firstname = "";
String _lastname = "";

// After:
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _firstname = "";
String _lastname = "";
```

This replaces manual controller management with Flutter's built-in Form validation system.

---

## Step 2: Remove initState and dispose Methods

**Location:** Remove the entire `initState()` and `dispose()` methods from `_MyFormState`

Remove these methods since we no longer need to manage TextEditingController listeners:

```dart
// Delete these methods entirely:
@override
void initState() {
  super.initState();
  _firstNameController.addListener(() {
    setState(() {
      _firstname = _firstNameController.text;
    });
  });
  _lastNameController.addListener(() {
    setState(() {
      _lastname = _lastNameController.text;
    });
  });
}

@override
void dispose() {
  _firstNameController.dispose();
  _lastNameController.dispose();
  super.dispose();
}
```

By using Form and TextFormField with `onChanged`, we no longer need these lifecycle methods.

---

## Step 3: Wrap Text Fields in a Form Widget

**Location:** In the Column's children, replace the two TextField widgets

Wrap the TextField widgets in a Form widget with the form key:

```dart
// Before:
TextField(
  decoration: const InputDecoration(labelText: "Firstname"),
  controller: _firstNameController,
),
TextField(
  decoration: const InputDecoration(labelText: "Lastname"),
  controller: _lastNameController,
),

// After:
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
```

Key changes:

- Wrap text fields in a Form widget with `key: _formKey`
- Replace TextField with TextFormField
- Remove controller parameter
- Add `onChanged` callback to update state directly
- Add `validator` function for form validation

---

## Step 4: Update Submit Button

**Location:** The "Submit" ElevatedButton in the Row

Replace the manual validation with form validation:

```dart
// Before:
ElevatedButton(
  onPressed: () {
    if (_firstname.isEmpty || _lastname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
    }
  },
  child: Text("Submit"),
),

// After:
ElevatedButton(
  onPressed: () {
    _formKey.currentState!.validate();
  },
  child: Text("Submit"),
),
```

The form's built-in validation will show error messages from the validator functions.

---

## Step 5: Update Clear Button

**Location:** The "Clear" ElevatedButton in the Row

Update the clear button to reset both state and form:

```dart
// Before:
ElevatedButton(
  onPressed: () {
    _firstNameController.clear();
    _lastNameController.clear();
  },
  child: Text("Clear"),
),

// After:
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
```

This clears both the state variables and resets the form fields and validation state.

---

## What I like

- No more text controllers to manage.
- Built-in validation with Form and TextFormField.

## What I don't like

- Need to manually aggregate form data.
- No complex form state such as dirty/pristine tracking.
