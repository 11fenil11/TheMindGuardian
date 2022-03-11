import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';

class DialogOkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: kPrimaryColor,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
