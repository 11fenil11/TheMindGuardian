import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/main.dart';
import 'package:url_launcher/url_launcher.dart';

class quizusage extends StatefulWidget {
  @override
  _quizusageState createState() => _quizusageState();
}

class _quizusageState extends State<quizusage> {
  static const _url = 'https://patient.info/doctor/patient-health-questionnaire-phq-9';
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:


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

                        new Text("Depression Check-up",

                          style: TextStyle(
                            // fontFamily: 'sfpro',
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,



                          ),

                        ),

                        new Container(
                          padding:new EdgeInsets.fromLTRB(15,50,15,50),
                          child: Column(
                            children: [
                              new Text(
                                "This quiz is standard depression quiz developed by Pfizer.inc. The copyright for the PHQ-9 was formerly held with Pfizer, who provided the educational grant for Drs Spitzer, Williams and Kroenke who originally designed it. For more information, check : ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              FlatButton(
                                onPressed: _launchURL,
                                child: Text("Link",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                ),
                              ),
                              SizedBox(   //Use of SizedBox
                                height: 30,
                              ),

                            ],
                          ),
                        ),
                        new Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.blue, borderRadius: BorderRadius.circular(50)),
                          child:FlatButton(

                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new MyQuiz()));
                            },

                            child: Text("START CHECK-UP", style: TextStyle(color: Colors.white, fontSize: 15),),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),),

            ],
          ),
        ),
      ),

    );
  }
}
