# Steps: From t01b_textfield.dart to t02b_text_controller.dart

## Overview

This guide demonstrates how to refactor from using `onChanged` callbacks in `TextField` to using `TextEditingController` for more efficient text input management.

## Key Changes

### 1. Add TextEditingController Instances

In the `_MyFormState` class, add two controller instances before the state variables:

```dart
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
String _firstname = "";
String _lastname = "";
```

**Before:**

```dart
String _firstname = "";
String _lastname = "";
```

**After:**

```dart
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
String _firstname = "";
String _lastname = "";
```

### 2. Add initState() Method

Add lifecycle management to listen to controller changes:

```dart
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
```

This replaces the `onChanged` callbacks in the TextField widgets.

### 3. Add dispose() Method

Clean up resources when the widget is disposed:

```dart
@override
void dispose() {
  _firstNameController.dispose();
  _lastNameController.dispose();
  super.dispose();
}
```

**Note:** Always dispose controllers to prevent memory leaks.

### 4. Update TextField Widgets

Remove `onChanged` callbacks and add the `controller` property:

**Before:**

```dart
TextField(
  decoration: const InputDecoration(labelText: "Firstname"),
  onChanged: (value) => setState(() {
    _firstname = value;
  }),
),
TextField(
  decoration: const InputDecoration(labelText: "Lastname"),
  onChanged: (value) => setState(() {
    _lastname = value;
  }),
),
```

**After:**

```dart
TextField(
  decoration: const InputDecoration(labelText: "Firstname"),
  controller: _firstNameController,
),
TextField(
  decoration: const InputDecoration(labelText: "Lastname"),
  controller: _lastNameController,
),
```

### 5. Update Clear Button Logic

Modify the "Clear" button to use the controller's `clear()` method:

**Before:**

```dart
ElevatedButton(
  onPressed: () {
    setState(() {
      _firstname = "";
      _lastname = "";
    });
  },
  child: Text("Clear"),
),
```

**After:**

```dart
ElevatedButton(
  onPressed: () {
    _firstNameController.clear();
    _lastNameController.clear();
  },
  child: Text("Clear"),
),
```

## Benefits of Using TextEditingController

1. **Separation of Concerns:** Controller logic is separated from UI callbacks
2. **Memory Management:** Proper resource cleanup through the `dispose()` method
3. **Direct Access:** Easy access to the text value via `.text` property
4. **Better Performance:** Efficient listener pattern instead of multiple setState calls
5. **Code Organization:** Cleaner and more maintainable code structure

# What I don't like

- Need to dispose controllers to avoid memory leaks
- The validation logic is located in the button's onPressed callback, not the TextField itself.
