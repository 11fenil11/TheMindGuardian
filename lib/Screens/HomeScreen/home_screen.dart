import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/Old%20Project/AfterController.dart';
import 'package:firebase_login/Old%20Project/Features.dart';
import 'package:firebase_login/Screens/HomeScreen/ExplorePageTab/explore_screen.dart';
import 'package:firebase_login/Screens/Login/login_screen.dart';
import 'package:firebase_login/Screens/ProfileScreen/profile_edit.dart';
import 'package:firebase_login/Screens/ProfileScreen/profile_view.dart';
import 'package:firebase_login/components/alert_dialog.dart';
import 'package:firebase_login/components/dialog_ok_button.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_login/Old Project/Features/INFO/APP_USAGE_info.dart';
import 'package:firebase_login/Old Project/Features/INFO/APP_USAGE_info.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const HomeScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            scrollable: true,
            titlePadding: EdgeInsets.only(top: 12, left: 24, right: 12),
            contentPadding: EdgeInsets.only(top: 12, left: 24, bottom: 20),
            insetPadding: EdgeInsets.symmetric(horizontal: 15,),
            backgroundColor: kPrimaryLightColor,
            title: new Text('Are you sure?', style: TextStyle(color: Colors.white,),),
            content: new Text('Do you want to exit an App',style: TextStyle(color: Colors.white),),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  child: Text("NO",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0,),),
                ),
              ),
              Text("  "),
              new GestureDetector(
                onTap: () => exit(0),
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  child: Text("YES",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0,),),
                ),
              ),
              Text("  "),
            ],
          )
    ) ?? false;
  }
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return WillPopScope(child: new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Color.fromRGBO(24, 22, 23, 1),
        centerTitle: true,
        actions: [IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.white,),
          iconSize: 28,
          tooltip: "Sign Out",
          onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            });
          },
        )],
      ),
      body: StreamBuilder<DocumentSnapshot> (
        stream: Firestore.instance.collection('users').document(widget.user.uid).snapshots(),
        builder: (BuildContext buildContext, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return AlertBox(
                context, 'Error!', snapshot.error, [DialogOkButton()])
                .showAlertDialog();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SpinKitCircle(size: 50, color: Colors.blue);
            default:
//              String name =  snapshot.data['name'];
              return Container(
                color: kPrimaryLightColor,
                child: getChild(currentIndex, snapshot.data),
              );
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),],
          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: kPrimaryColor, size: 32,),
                title: Text('Home', style: TextStyle(color: kPrimaryColor),),
                backgroundColor: kPrimaryLightColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore, color: kPrimaryColor, size: 32,),
                title: Text('Explore', style: TextStyle(color: kPrimaryColor),),
                backgroundColor: kPrimaryLightColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: kPrimaryColor, size: 32,),
                title: Text('Account', style: TextStyle(color: kPrimaryColor),),
                backgroundColor: kPrimaryLightColor,
              ),
            ],
          ),
        ),
      ),
    )
        , onWillPop: _onBackPressed);

  }


  Widget getChild(currentIndex, DocumentSnapshot snapshot) {
    switch(currentIndex) {
      case 0:
        return Features_page();
      case 1:
        return ExploreScreen();
      case 2:
        return ProfileViewScreen(documentSnapshot: snapshot,);
      default:
        return ProfileViewScreen(documentSnapshot: snapshot,);
    }
  }
}


//Change


//class HomeScreen extends StatefulWidget {
//  final FirebaseUser user;
//
//  const HomeScreen({
//    Key key,
//    this.user
//  }) : super(key: key);
//
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  int currentIndex = 0;
//  @override
//  Widget build(BuildContext context) {
//    Widget child;
//    switch (currentIndex) {
//      case 0:
//        child = HomeScreen();
//        break;
//      case 1:
//        child = ExploreScreen();
//        break;
//      case 2:
//        child = ProfileViewScreen();
//        break;
//      case 3:
//        child = SettingScreen();
//        break;
//    }
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Welcome'),
//        actions: [IconButton(
//          icon: Icon(Icons.exit_to_app, color: Colors.white,),
//          tooltip: "Sign Out",
//          onPressed: () async {
//            await FirebaseAuth.instance.signOut().then((value) {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//            });
//          },
//        )],
//      ),
//      body: SizedBox.expand(child: child,),
////      body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute,),
////      body: StreamBuilder<DocumentSnapshot> (
////        stream: Firestore.instance.collection('users').document(widget.user.uid).snapshots(),
////        builder: (BuildContext buildContext, AsyncSnapshot<DocumentSnapshot> snapshot) {
////          if (snapshot.hasError) {
////            return AlertBox(
////                context, 'Error!', snapshot.error, [DialogOkButton()])
////                .showAlertDialog();
////          }
////          switch (snapshot.connectionState) {
////            case ConnectionState.waiting:
////              return SpinKitCircle(size: 50, color: Colors.blue);
////            default:
////              String name =  snapshot.data['name'];
////              String email = snapshot.data['email'];
////              String phoneNumber = snapshot.data['phoneNumber'];
////              int age = snapshot.data['age'];
////              return Center(
////                child: Text(
////                  snapshot.data['name'] != null ? snapshot.data['name'] : '',
////                  style: TextStyle(
////                      fontSize: 24,
////                      fontWeight: FontWeight.bold
////                  ),
////                ),
////              );
////          }
////        }
////      ),
//      bottomNavigationBar: BottomNavyBar(
//        selectedIndex: currentIndex,
//        showElevation: true,
//        itemCornerRadius: 8,
//        curve: Curves.easeInBack,
//        onItemSelected: (index) => setState(() {
//          currentIndex = index;
//        }),
//        items: [
//          BottomNavyBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//            activeColor: Colors.purpleAccent,
//            textAlign: TextAlign.center,
//          ),
//          BottomNavyBarItem(
//            icon: Icon(Icons.explore),
//            title: Text('Explore'),
//            activeColor: Colors.redAccent,
//            textAlign: TextAlign.center,
//          ),
//          BottomNavyBarItem(
//            icon: Icon(Icons.account_circle),
//            title: Text('Account'),
//            activeColor: Colors.pink,
//            textAlign: TextAlign.center,
//          ),
//          BottomNavyBarItem(
//            icon: Icon(Icons.settings),
//            title: Text('Settings'),
//            activeColor: Colors.blue,
//            textAlign: TextAlign.center,
//          )
//        ],
//      ),
//    );
//  }
//
////  onSelected(int tabIndex) {
////    switch(tabIndex) {
////      case 0:
////        _navigatorKey.currentState.pushReplacementNamed("Home");
////        break;
////      case 1:
////        _navigatorKey.currentState.pushReplacementNamed("Explore");
////        break;
////      case 2:
////        _navigatorKey.currentState.pushReplacementNamed("Account");
////        break;
////      case 3:
////        _navigatorKey.currentState.pushReplacementNamed("Settings");
////        break;
////    }
////    setState(() {
////      currentIndex = tabIndex;
////    });
////  }
////
////  Route<dynamic> generateRoute (RouteSettings settings) {
////    switch(settings.name) {
////      case "Home":
////        break;
////      case "Explore":
////        return MaterialPageRoute(builder: (context) => ExploreScreen());
////      case "Account":
////        return MaterialPageRoute(builder: (context) => ProfileViewScreen());
////      case "Settings":
////        return MaterialPageRoute(builder: (context) => SettingScreen());
////      default:
////        return MaterialPageRoute(builder: (context) => HomeScreen());
////    }
////  }
//}
//
