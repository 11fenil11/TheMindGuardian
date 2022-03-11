import 'package:firebase_login/constraints.dart';
import 'package:firebase_login/Screens/HomeScreen/home_screen.dart';
import 'package:firebase_login/Screens/Login/components/background.dart';
import 'package:firebase_login/Screens/SignUp/signup_screen.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/already_have_an_account_check.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/components/rounded_button.dart';
import 'package:firebase_login/components/rounded_input_field.dart';
import 'package:firebase_login/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              SvgPicture.asset
                (
                'assets/icons/login.svg',
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                onSaved: (input) => _email = input,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                onSaved: (input) => _password = input,
                hintText: "Password",
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password cannot be less than 8 characters';
                  }
                  return null;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: logIn,
                color: Color.fromRGBO(17, 0, 255, 1),
              ),
              SizedBox(height: size.height * 0.03,),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      }
                    )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseUser user = (await auth.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
      } catch(e) {
        // print(e.message);
        AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
        alertBox.showAlertDialog();
      }
    }
  }
}

//class PageLoading extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return FlutterEasyLoading(
//      child: MaterialApp(
//        home: HomeScreen(user: user),
//      ),
//    );
//  }
//}









