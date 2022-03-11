import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:usage_stats/Profile.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/main.dart';
import 'Features.dart' ;


void main() => runApp(AfterController());

class AfterController extends StatefulWidget{
  @override
  _AfterControllerState createState() => _AfterControllerState();
}

class _AfterControllerState extends State<AfterController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: after_controller(),

    );
  }
}

class after_controller extends StatefulWidget {

  @override
  _after_controllerState createState() => _after_controllerState();
}

class _after_controllerState extends State<after_controller> {
  int cuttentIndext = 0;
  final List<Widget> _children =[
    Features_page(),
  ];
  void onTappedBar(int index){
    setState(() {
      cuttentIndext = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[cuttentIndext],
      bottomNavigationBar: CurvedNavigationBar(
        index: cuttentIndext,
        animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.black,
        color: Color.fromRGBO(24, 22, 23, 1),
        items: <Widget>[
          Icon(Icons.add, size: 30, color: Color.fromRGBO(17, 0, 255, 1)),
          Icon(Icons.list, size: 30, color: Color.fromRGBO(17, 0, 255, 1)),
          Icon(Icons.compare_arrows, size: 30, color: Color.fromRGBO(17, 0, 255, 1)),
        ],
        onTap: onTappedBar,

      ),
    );
  }
}
