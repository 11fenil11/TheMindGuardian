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
import 'package:firebase_login/components/rounded_textfield.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const ProfileEditScreen({
    Key key,
    @required this.documentSnapshot,
  }) : super(key: key);

  @override
  _ProfileEditScreenState createState()  => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String _email, _name, _phoneNumber, _address;
  String initialName, initialEmail, initialPhoneNumber, initialAddress;
  String initialProfileImage;
  DateTime _dob;
  String initialAge;
  bool nameEdited = false, emailEdited = false, phoneEdited = false, addressEdited = false;
  bool birthDateEdited = false, ageEdited = false;
  String _age;
  String initialDob;

  TextEditingController _birthDate = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    initialName = widget.documentSnapshot['name'] ==  null ? null : widget.documentSnapshot['name'];
    initialEmail = widget.documentSnapshot['email'] ==  null ? null : widget.documentSnapshot['email'];
    initialPhoneNumber = widget.documentSnapshot['phoneNumber'] == null ? null : widget.documentSnapshot['phoneNumber'];
    initialAge = widget.documentSnapshot['age'] == null ? null : widget.documentSnapshot['age'];
    initialAddress = widget.documentSnapshot['address'] == null ? null : widget.documentSnapshot['address'];
    initialProfileImage = widget.documentSnapshot['image'] == null ? null : widget.documentSnapshot['image'];
    initialDob = widget.documentSnapshot['birthDate'] == null ? null : widget.documentSnapshot['birthDate'];
    if(_dob != null)
    {
      _birthDate.value = TextEditingValue(text: formatDate(_dob, [dd, '-', mm, '-', yyyy]));
    }
    else
    {
      if(initialDob != null)
      {
        _birthDate.value = TextEditingValue(text: initialDob);
      } else {
        _birthDate.value = TextEditingValue(text: ' ');
      }
    }

    // print(initialDob);
    // print(_dob);

    return Scaffold(
      appBar: AppBar(
        title: Text('EditScreen'),
        centerTitle: true,
        backgroundColor: kPrimaryLightColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 8,),
                GestureDetector(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: kPrimaryColor,
                    backgroundImage: initialProfileImage == null ? AssetImage('assets/images/avatar.png') : NetworkImage(initialProfileImage),
                  ),
                  onTap: uploadProfilePicture,
                ),
                RoundedInputField(
                  initialValue: initialName,
                  hintText: "Your Name",
                  icon: Icons.person,
                  onChanged: (value) {
                    _name = value;
                    nameEdited = true;
                  }
                ),
                RoundedTextField(
                  initialValue: initialEmail,
                  icon: Icons.email,
                  onChanged: (value) {
                    _email = value;
                    emailEdited = true;
                  },
                ),
                RoundedInputField(
                  initialValue: initialPhoneNumber,
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone_android,
                  onChanged: (value) {
                    _phoneNumber = value;
                    phoneEdited = true;
                  }
                ),
                RoundedInputField(
                  controller: _birthDate,
                  hintText: "Date of Birth",
                  icon: Icons.cake,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range, color: kPrimaryColor,),
                    onPressed: pickDate,
                  ),
                ),
                RoundedInputField(
                  initialValue: initialAge,
                  keyboardType: TextInputType.number,
                  hintText: "Age",
                  icon: Icons.alternate_email,
                  onChanged: (value) {
                    _age = value;
                    ageEdited = true;
                  },
                ),
                RoundedInputField(
                  initialValue: initialAddress,
                  hintText: "Your Address",
                  icon: Icons.location_on,
                  onChanged: (value) {
                    _address = value;
                    addressEdited = true;
                  }
                ),
                RoundedButton(
                  text: "Submit",
                  press: updateProfile,
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getInitialDob() async {
    var dob = await FirebaseAuth.instance.currentUser().then((value) {
      Firestore.instance.collection('users').document(value.uid).get().then((value) => value['birthDate']);
    });

    return dob;
  }

  pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    ).then((date) {
      setState(() {
        _dob = date;
        _birthDate.value = TextEditingValue(text: formatDate(date, [dd, '-', mm, '-', yyyy]));
        birthDateEdited = true;
        // print('updated date');
        // print(_dob);
      });
    });
  }

  Future<void> updateProfile() async {
    final formState = _formKey.currentState;
    String updatedName = nameEdited ? _name : initialName;
    String updatedEmail = emailEdited ? _email : initialEmail;
    String updatedPhone = phoneEdited ? _phoneNumber : initialPhoneNumber;
    String updatedAddress = addressEdited ? _address : initialAddress;
    String updatedBirthDate = birthDateEdited ? formatDate(_dob, [dd, '-', mm, '-', yyyy]) : initialDob;
    String updatedAge = ageEdited ? _age : initialAge;

    //-----------------------------------------Change-------------------------------------------


    defaultUploadProfilePicture();
    //-----------------------------------------Change-------------------------------------------
    // print(updatedBirthDate);
    if(formState.validate()) {
      formState.save();
      try {
        FirebaseAuth.instance.currentUser().then((value) =>
            Firestore.instance.collection('users').document(value.uid).updateData({
              'email': updatedEmail,
              'name': updatedName,
              'address': updatedAddress,
              'phoneNumber': updatedPhone,
              'age': updatedAge,
              'birthDate' : updatedBirthDate,
            })
        ).then((value) {
          Navigator.pop(context);
          AlertBox alertBox = new AlertBox(context, "Profile Update Successful!", "Profile Info has been updated Successfully! ", [DialogOkButton()]);
          alertBox.showAlertDialog();
        });
      } catch (e) {
        AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
        alertBox.showAlertDialog();
      }
    }

  }
  //Default Profile picture------------------------------------------change
  defaultUploadProfilePicture() async {
    if(initialProfileImage == null)
      {
        final File image = File("abjs.png");
        try {
          String profileImage = await uploadImage(image);
          FirebaseAuth.instance.currentUser().then((value) async {
            Firestore.instance.collection('users').document(value.uid).updateData({
              'image': 'https://firebasestorage.googleapis.com/v0/b/themindguardian-c90ba.appspot.com/o/profileImage%2Favatar.png?alt=media&token=85b20826-bae8-420a-8874-7520811919aa',
            });
          }).then((value) {
            Navigator.pop(context);
            AlertBox alertBox = new AlertBox(context, "Default Profile Image Updated!", "Default Profile Image has been updated Successfully! ", [DialogOkButton()]);
            alertBox.showAlertDialog();
          });
        } catch (e) {
          AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
          alertBox.showAlertDialog();
        }
      }
  }
  //Default Profile picture------------------------------------------change
  uploadProfilePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 25, //change---quality----------------
    );
    final File image = File(pickedImage.path);
    try {
      String profileImage = await uploadImage(image);
      FirebaseAuth.instance.currentUser().then((value) async {
        Firestore.instance.collection('users').document(value.uid).updateData({
          'image': profileImage,
        });
      }).then((value) {
        Navigator.pop(context);
        AlertBox alertBox = new AlertBox(context, "Profile Image Updated!", "Profile Image has been updated Successfully! ", [DialogOkButton()]);
        alertBox.showAlertDialog();
      });
    } catch (e) {
      AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
      alertBox.showAlertDialog();
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage(storageBucket: "gs://themindguardian-c90ba.appspot.com");
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      var uploadTask = storage.ref().child("profileImage/${user.uid}").putFile(image);
      var completedTask = await uploadTask.onComplete;
      String downloadUrl = await completedTask.ref.getDownloadURL();
      return downloadUrl;
    } catch(e) {
      AlertBox alertBox = new AlertBox(context, "Error!", e.message, [DialogOkButton()]);
      alertBox.showAlertDialog();
      return null;
    }

  }
}

