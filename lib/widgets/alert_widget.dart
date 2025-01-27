import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String name) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context, true);
    },
  );
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      "$title",
      style: TextStyle(color: Colors.red),
    ),
    content: Text("$name"),
    actions: [
      okButton,
      cancelButton
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
