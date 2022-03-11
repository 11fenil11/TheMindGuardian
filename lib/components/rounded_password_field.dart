import 'package:firebase_login/components/text_field_container.dart';
import 'package:flutter/material.dart';
import '../constraints.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Function onSaved;
  final Function validator;
  final String hintText;
  RoundedPasswordField({
    Key key,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool makeVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: makeVisible ? false : true,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        style: TextStyle(
          color: Colors.white,
        ),
        validator: (value) {
          if(value.length < 8) {
            return 'Password Cannot be less than 8 characters';
          } return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.white
          ),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: makeVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                if(makeVisible) {
                  makeVisible = false;
                } else {
                  makeVisible = true;
                }
              });
            },
            color: kPrimaryColor,
            tooltip: "Password Visibility",
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
