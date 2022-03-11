import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/BRAINMRI/main.dart';
import 'package:flutter/material.dart';
// import 'package:example/Features/MAIN_CONTENT/main.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/main.dart';
import 'package:firebase_login/Old Project/Features/INFO/BrainTumor.dart';

class mriusage extends StatefulWidget {
  @override
  _mriusageState createState() => _mriusageState();
}

class _mriusageState extends State<mriusage> {
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

                        new Text('Brain Tumour Detection',

                          style: TextStyle(
                            // fontFamily: 'sfpro',
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,



                          ),

                        ),

                        new Container(
                          padding:new EdgeInsets.fromLTRB(15,50,15,50),
                          child: new Text("'Brain Tumour Detector' predicts whether the tumor is present or not in uploaded Brain MRI image of patient. The model used in prediction is Resnet-50. It also shows confidence of that prediction.",
                            style: TextStyle(

                              fontSize: 18,
                              color: Colors.white,
                            ),),),
                        new Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.blue, borderRadius: BorderRadius.circular(50)),
                          child:FlatButton(

                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new BRAIN_MRI()));
                            },

                            child: Text("START DETECTION", style: TextStyle(color: Colors.white, fontSize: 15),),

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
