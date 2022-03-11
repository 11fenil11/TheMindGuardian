// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/Screens/HomeScreen/home_screen.dart';
import 'package:firebase_login/Screens/Login/login_screen.dart';
import 'package:firebase_login/Screens/SignUp/components/background.dart';
import 'package:firebase_login/Screens/SignUp/components/or_divider.dart';
import 'package:firebase_login/Screens/SignUp/components/social_icon.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/already_have_an_account_check.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/components/rounded_button.dart';
import 'package:firebase_login/components/rounded_input_field.dart';
import 'package:firebase_login/components/rounded_password_field.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/components/rounded_button.dart';
import 'package:firebase_login/components/rounded_input_field.dart';
import 'package:firebase_login/constraints.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget
{
  final DocumentSnapshot documentSnapshot;
  const Body({Key key, @required this.documentSnapshot}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password, _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03,),
              Text(
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.3,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
                onSaved: (input) => _email = input,
              ),
              RoundedPasswordField(
                hintText: "Password",
                onChanged: (value) {},
                onSaved: (input) => _password = input,
              ),
              RoundedPasswordField(
                hintText: "Confirm Password",
                onChanged: (value) {},
                onSaved: (input) => _confirmPassword = input,
              ),
              RoundedButton(
                text: "SIGN UP",
                press: signUp,
                color:  Color.fromRGBO(17, 0, 255, 1)
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      }
                    ),
                  );
                },
              ),
              //Google Sign-In
              // OrDivider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocialIcon(
              //       iconSrc: "assets/icons/facebook.svg",
              //       press: () {},
              //     ),
              //     SocialIcon(
              //       iconSrc: "assets/icons/google-plus.svg",
              //       press: googleSignIn,
              //     ),
              //     SocialIcon(
              //       iconSrc: "assets/icons/twitter.svg",
              //       press: () {},
              //     ),
              //   ],
              // ),
              SizedBox(height: 12,),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    FirebaseUser user;
    bool isSignedIn = await _googleSignIn.isSignedIn();

    if(isSignedIn) {
      user = await _auth.currentUser();
      // print("here");
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );
      // print("there");
      user = (await _auth.signInWithCredential(credential)).user;
      await Firestore.instance.collection('users').document(user.uid).setData({
        'name': user.displayName,
        'image': user.photoUrl,
      });
    }
    // print(user);
    return user;
  }

  void googleSignIn() async {
    try{
      FirebaseUser user = await _handleSignIn();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user,)));
      AlertBox alertBox = new AlertBox(context, "SignUp Successful!", "Google SignIn Successful", [DialogOkButton()]);
      alertBox.showAlertDialog();
    } catch (e) {
      AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
      alertBox.showAlertDialog();
    }
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        // print(_email);
        // print(_password);
        if(_password == _confirmPassword) {
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value)
          {
            // print(value.user.uid);
            Firestore.instance.collection('users').document(value.user.uid).setData({
              'email': _email,
            });
          }).then((value) {
            Widget loginButton = FlatButton(
              child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            );
            //change
            defaultUploadProfilePicture();

            AlertBox alertBox = new AlertBox(context, "SignUp Successful!", "You have Signed Up Successfully! Login now to explore more!", [loginButton]);
            alertBox.showAlertDialog();
          });
        } else {
          AlertBox alertBox = new AlertBox(context, "Password Error!", "Password fields do not match", [DialogOkButton()]);
          alertBox.showAlertDialog();
        }
      } catch(e) {
        // print(e.message);
        AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
        alertBox.showAlertDialog();
      }
    }
  }

//Default Profile picture------------------------------------------change
  defaultUploadProfilePicture() async {

      print("Default Upload profile call----------------");
      // final picker = ImagePicker();
      // final pickedImage = await picker.getImage(source: ImageSource.gallery);
      // final File image = File(pickedImage.path);
      // final File image = File("C:/Users/fparmar/Documents/domr thun/Study/Project/FInal/Flutter-BaseApp-master/assets/images/avatar.png");
      // final File image = File("abjs.png");
      try {
        // String profileImage = await uploadImage(image);
        FirebaseAuth.instance.currentUser().then((value) async {
          Firestore.instance.collection('users').document(value.uid).updateData({
            'address' : 'Not added by user',
            'age' : '0',
            'birthDate' : 'Not added by user',
            'image': 'https://firebasestorage.googleapis.com/v0/b/themindguardian-c90ba.appspot.com/o/profileImage%2Favatar.png?alt=media&token=85b20826-bae8-420a-8874-7520811919aa',
            'name': 'Not added by user',
            'phoneNumber': 'Not added by user',
          });
        });
        Map<String,dynamic> mapTemp = {
          "Instagram" : [0,0],
          "Whatsapp" : [0,0],
          "LinkedIn" : [0,0],
          "Call Of Duty" : [0,0],
          "Facebook" : [0,0],
          "Youtube" : [0,0]
        };

        FirebaseAuth.instance.currentUser().then((value) async
        {
          Firestore.instance.collection('users').document(value.uid).collection("AppUsageStats").add({
            'Apps' : mapTemp,
            "endDate" : Timestamp.fromDate(DateTime.now()),
            "startDate" : Timestamp.fromDate(DateTime.now().subtract(Duration(days: 7)))
          });
        });
      } catch (e) {
        // AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
        // alertBox.showAlertDialog();
      }
  }

//Default Profile picture------------------------------------------change
}
