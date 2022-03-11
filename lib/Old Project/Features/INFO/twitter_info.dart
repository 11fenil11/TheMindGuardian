import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/main.dart';

class twitterinfo extends StatefulWidget {
  @override
  _twitterinfoState createState() => _twitterinfoState();
}

class _twitterinfoState extends State<twitterinfo> {
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

                        new Text('Sentimental Analysis',

                          style: TextStyle(
                            // fontFamily: 'sfpro',
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),

                        ),

                        new Container(
                        padding:new EdgeInsets.fromLTRB(15,50,15,50),
                        child: new Text("Sentiment analysis predicts the polarity of a text. It not only shows whether the text is positive or negative, but also gives idea of positive and negative words in the text with their polarity values.",
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
                                  builder: (context) => new MyCustomForm()));
                            },

                            child: Text("START ANALYSIS", style: TextStyle(color: Colors.white, fontSize: 15),),

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
