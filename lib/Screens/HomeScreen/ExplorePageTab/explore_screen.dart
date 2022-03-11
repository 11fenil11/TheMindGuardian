import 'package:date_format/date_format.dart';
import 'package:firebase_login/Screens/HomeScreen/ExplorePageTab/user_profile.dart';
import 'package:firebase_login/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/Old Project/Features/INFO/APP_USAGE_info.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/components/rounded_button.dart';
import 'package:firebase_login/components/rounded_input_field.dart';
import 'package:firebase_login/constraints.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Future _future;
  List<User> filteredList = [];
  List<User> dummyUserList = List<User>();
  List<String> userNames = [];
  List<String> emailNames = [];
  List<User> users = [];
  Map<String,dynamic> appUsageMaps = Map();
  TextEditingController editingController = new TextEditingController();
  String filter = "";


//---------------------------------Change------------------------------------------------------------------------------------------
//   Future<List<User>> getUsers() async {
//     final firestoreInstance = Firestore.instance;
//       firestoreInstance.collection("users").get().then((querySnapshot) {
//         querySnapshot.docs.forEach((result) {
//           print(result.data());
//         });
//       });
//
//     return users;
//   }
//   getFireUsers()
  Future<List<User>> getUsers() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = Firestore.instance;
    FirebaseUser loggedInUser;


    // Response response = await get('https://randomuser.me/api/?seed=1&results=50&page=1');
    // var data = json.decode(response.body);
    // var usersJson = data['results'];

    final QuerySnapshot userDocSnap = await Firestore.instance.collection('users').getDocuments();
    final int userSnapLength = userDocSnap.documents.length;

    // print("Number of Users : ${userSnapLength}");
    // print(userSnapLength);


    for(var i=0; i<userSnapLength; i++) {
      Map currentUser = userDocSnap.documents[i].data;
      //Change------------------------------------

      final QuerySnapshot userNap = await Firestore.instance.collection('users').document(userDocSnap.documents[i].documentID).collection("AppUsageStats").getDocuments();
      Map<String,dynamic> appTempStats = userNap.documents[0].data["Apps"];

      // print(appDocId);
      // final QuerySnapshot userNap = await Firestore.instance.collection('users').document(userDocSnap.documents[i].documentID).collection("AppUsageStats").getDocuments();
      // final DocumentSnapshot userNap = await Firestore.instance.collection('users').document(userDocSnap.documents[i].documentID).collection("AppUsageStats").;
      // Map usData = userNap.documents[0].data["Apps"];
      // final QuerySnapshot userNap = await Firestore.instance.collection('users').document(userDocSnap.documents[i].documentID).collection("AppUsageStats").document(qSnap.documents[0].documentID);
      // String docPath = userNap.documents[0].;
      // Map<String,dynamic> mpApp = usData.
      //map usdata = usern
      // _firestore.collection("users").document(loggedInUser.uid).collection("AppUsageStats").
      //Change------------------------------------
      // print(currentUser);

      String fullName = "Not added bu user";
      String dateOfBirth = "Not added bu user";
      String email = "Not added bu user";
      String phoneNumber = "Not added bu user";
      int age = 0;
      String address = "Not added bu user";
      String image = "assets/images/avatar.png";

      fullName = currentUser['name'];
      dateOfBirth = currentUser['birthDate'];
      email = currentUser['email'];
      phoneNumber = currentUser['phoneNumber'];
      age = int.parse(currentUser['age']);
      image = currentUser['image'];
      address = currentUser['address'];
      appUsageMaps = appTempStats;
      //
      // print(fullName);
      // print(dateOfBirth);
      // print(email);
      // print(phoneNumber);
      // print(age);
      // print(image);
      // print(address);
      //
      // print("UserId of ${email}: ");
      // print(userDocSnap.documents[i].documentID);
      // // print(userNap);
      // print("Metadata of ${email} : ");
      // print(userNap.documents);
      // print(docPath);
      // print(usData);
      // print("App Usage Data of ${email} ");
      // print(usData);


      // Map name = currentUser['name'];
      // String fullName = name['title'] + ' ' + name['first'] + ' ' + name['last'];
      // Map location = currentUser['location'];
      // Map street = location['street'];
      // String streetName = street['number'].toString() + ' ' + street['name'];
      // String address = streetName + location['city'] + ' ' + location['state'] + ' ' + location['country'] + ' ' + location['postcode'].toString();
      // Map picture = currentUser['picture'];
      // String image = picture['medium'];
      // Map dob = currentUser['dob'];
      // String date = dob['date'];
      // DateTime birthDate = DateTime.parse(date);
      // String dateOfBirth = formatDate(birthDate, [dd, '-', mm, '-', yyyy]);
      // int age = dob['age'];

      // User user = User(fullName, currentUser['email'], currentUser['phone'], dateOfBirth, age, image, address);
      User user = User(
          fullName,
          email,
          phoneNumber,
          dateOfBirth,
          age,
          image,
          address,
          appUsageMaps,
      );
      users.add(user);
      userNames.add(fullName.toLowerCase());
      emailNames.add(email.toLowerCase());
      dummyUserList.add(user);
    }
    return users;
  }
//---------------------------------Change------------------------------------------------------------------------------------------



  // Future<List<User>> getUsers() async {
  //   Response response = await get('https://randomuser.me/api/?seed=1&results=50&page=1');
  //   var data = json.decode(response.body);
  //   var usersJson = data['results'];
  //
  //   for(var i=0; i<usersJson.length; i++) {
  //     Map currentUser = usersJson[i];
  //     Map name = currentUser['name'];
  //     String fullName = name['title'] + ' ' + name['first'] + ' ' + name['last'];
  //     Map location = currentUser['location'];
  //     Map street = location['street'];
  //     String streetName = street['number'].toString() + ' ' + street['name'];
  //     String address = streetName + location['city'] + ' ' + location['state'] + ' ' + location['country'] + ' ' + location['postcode'].toString();
  //     Map picture = currentUser['picture'];
  //     String image = picture['medium'];
  //     Map dob = currentUser['dob'];
  //     String date = dob['date'];
  //     DateTime birthDate = DateTime.parse(date);
  //     String dateOfBirth = formatDate(birthDate, [dd, '-', mm, '-', yyyy]);
  //     int age = dob['age'];
  //
  //     User user = User(fullName, currentUser['email'], currentUser['phone'], dateOfBirth, age, image, address);
  //
  //     users.add(user);
  //     userNames.add(fullName.toLowerCase());
  //     dummyUserList.add(user);
  //   }
  //   return users;
  // }


  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<User> filteredList = List<User>();

      for(var i=0; i < userNames.length; i++) {
        if(userNames[i].contains(query)) {
          filteredList.add(dummyUserList[i]);
        }else if(emailNames[i].contains(query)){
          filteredList.add(dummyUserList[i]);
        }
      }

//      userNames.forEach((item) {
//        if(item.contains(query)) {
//          filteredList.add(item);
//        }
//      });
      setState(() {
        users.clear();
        users.addAll(filteredList);
        // print(filteredList);
      });
      return;
    } else {
      setState(() {
        users.clear();
        users.addAll(dummyUserList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _future = getUsers();
    // dynamic goTemp = getFireUsers(); //change----------------------------------
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        color: Colors.black,
        child: new Container(
        padding: new EdgeInsets.fromLTRB(0,50,0,0),

    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            style: TextStyle(
               color: Colors.white,
            ),
            onChanged: (value) {
              // print("Value" + value);
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: "Search",
              labelStyle: TextStyle(color: Colors.white),
              hintText: "Search Here...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search,color: Colors.white,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                color: Color.fromRGBO(17, 0, 255, 1),
                )
              )
            ),
          ),
        ),
        FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.lightBlue,
                    size: 50,
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(users[index].image),
                          ),
                          title: Text(users[index].name,style: TextStyle(color: Colors.white),),
                          subtitle: Text(users[index].email,style: TextStyle(color: Colors.grey),),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UserProfile(users[index]);
                                  }
                                )
                            );
                          },
                        ),
                        Divider(
                          thickness: 1.2,
                          indent: 10,
                          endIndent: 10,
                        )
                      ],
                    );
                  }
                ),
              );
            }
          },
        ),
      ],
    ),), );
  }
}
