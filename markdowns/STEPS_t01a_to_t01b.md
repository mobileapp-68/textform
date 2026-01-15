# Steps to Transform t01a_textfield.dart to t01b_textfield.dart

## Overview

This guide walks through adding state management and form functionality to a basic TextField widget layout.

---

## Step 1: Add State Variables

**Location:** In the `_MyFormState` class, right after the class declaration

Add two string variables to track the input values:

```dart
String _firstname = "";
String _lastname = "";
```

These variables will store the values entered by the user in the text fields.

---

## Step 2: Update the Title Text Widget

**Location:** The `Text("Fullname:")` widget in the Column children

Change the static text to display the current input values:

```dart
// Before:
Text("Fullname:", style: TextStyle(fontSize: 24, fontWeight: .bold)),

// After:
Text(
  "Fullname: $_firstname $_lastname",
  style: TextStyle(fontSize: 24, fontWeight: .bold),
),
```

This displays the concatenated first and last names as the user types.

---

## Step 3: Add onChanged Listener to Firstname TextField

**Location:** The first `TextField` widget

Update the Firstname TextField to capture input changes:

```dart
// Before:
TextField(decoration: const InputDecoration(labelText: "Firstname")),

// After:
TextField(
  decoration: const InputDecoration(labelText: "Firstname"),
  onChanged: (value) => setState(() {
    _firstname = value;
  }),
),
```

The `onChanged` callback updates the `_firstname` state variable whenever the user types.

---

## Step 4: Add onChanged Listener to Lastname TextField

**Location:** The second `TextField` widget

Update the Lastname TextField to capture input changes:

```dart
// Before:
TextField(decoration: const InputDecoration(labelText: "Lastname")),

// After:
TextField(
  decoration: const InputDecoration(labelText: "Lastname"),
  onChanged: (value) => setState(() {
    _lastname = value;
  }),
),
```

This updates the `_lastname` state variable whenever the user types.

---

## Step 5: Implement Submit Button Logic

**Location:** The first `ElevatedButton` (Submit button)

Add validation and error handling:

```dart
// Before:
ElevatedButton(onPressed: () {}, child: Text("Submit")),

// After:
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
```

This checks if either field is empty and shows a SnackBar error message if validation fails.

---

## Step 6: Implement Clear Button Logic

**Location:** The second `ElevatedButton` (Clear button)

Add functionality to reset both fields:

```dart
// Before:
ElevatedButton(onPressed: () {}, child: Text("Clear")),

// After:
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

This clears both the state variables, which resets the text fields and the display text.

---

## Summary of Changes

| Change                                     | Purpose                           |
| ------------------------------------------ | --------------------------------- |
| Add `_firstname` and `_lastname` variables | Store user input                  |
| Update title Text to show values           | Display live input                |
| Add `onChanged` to both TextFields         | Capture user input                |
| Add Submit button validation               | Ensure required fields are filled |
| Add Clear button logic                     | Reset the form                    |

The result is a functional form that displays entered values in real-time, validates input, and provides clear and submit actions.
