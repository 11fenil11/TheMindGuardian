import 'package:firebase_login/components/text_field_container.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Function validator;
  final Function onSaved;
  final String initialValue;
  final Widget suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const RoundedTextField({
    Key key,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        enabled: false,
        style: TextStyle(
          color: Color.fromRGBO(17, 0, 255, 1),
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
