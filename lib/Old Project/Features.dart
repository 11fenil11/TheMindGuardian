
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/main.dart';
import 'package:firebase_login/Old Project/Features/INFO/twitter_info.dart';
import 'package:firebase_login/Old Project/Features/INFO/APP_USAGE_info.dart';
import 'package:firebase_login/Old Project/Features/INFO/MRI_info.dart';
import 'package:firebase_login/Old Project/Features/INFO/QUIZ_info.dart';
import 'package:firebase_login/Old Project/Features/INFO/BrainTumor.dart';


class Features_page extends StatefulWidget{

  @override
  _Features_pageState createState() => _Features_pageState();
}


class _Features_pageState extends State<Features_page> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false, //change yellow update line
      body:
      SingleChildScrollView(
        child: (
            new Container(
              padding: new EdgeInsets.fromLTRB(0,90,0,0),
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new SizedBox(
                      width: 350.0,
                      height: 650.0,
                      child: new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        color: Color.fromRGBO(24, 22, 23, 1),
                        child: new Container(
                          padding: new EdgeInsets.fromLTRB(0,50,0,0),
                          child: new Column(

                            children: <Widget>[

                              new Text('Features',

                                style: TextStyle(
                                  // fontFamily: 'sfpro',
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,



                                ),

                              ),
                              new Container(
                                padding: new EdgeInsets.fromLTRB(20,0,0,0),
                                child: Listss(context),
                              ),


                            ],
                          ),
                        ),
                      ),),

                  ],
                ),
              ),
            )
        ),
      ),
    );

  }
}



Widget Listss(BuildContext context){

  var listView = ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: <Widget>[

      ListTile(

        leading: Icon(Icons.text_fields,
          color: Color.fromRGBO(17, 0, 255, 1),),
        title: Text("Text Sentimental Analysis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,

          ),),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => new twitterinfo()));
          },
      ),

      ListTile(

        leading: Icon(Icons.local_hospital,
            color: Color.fromRGBO(17, 0, 255, 1)),
        title: Text("Brain Tumour Detection",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,

          ),),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new mriusage()));
        },
      ),
      ListTile(

        leading: Icon(Icons.check,
            color: Color.fromRGBO(17, 0, 255, 1)),
        title: Text("Depression Check-up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,

          ),),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new quizusage()));
        },
      ),
      ListTile(

        leading: Icon(Icons.shutter_speed,
            color: Color.fromRGBO(17, 0, 255, 1)),
        title: Text("Daily Usage",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,

          ),),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new appusage()));
        },
      ),
    ],


  );
  return listView;
}