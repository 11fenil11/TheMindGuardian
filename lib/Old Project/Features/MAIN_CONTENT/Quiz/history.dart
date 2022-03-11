import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/main.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/result.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShowHistory extends StatefulWidget {
  final List _myList;
  final List _Time;
  final int resultScore;
  final Function resetHandler;
  ShowHistory(this._myList,this._Time,this.resultScore,this.resetHandler);
  // This widget is the root of the application.
  @override
  _ShowHistoryState createState() =>_ShowHistoryState(_myList,_Time,resultScore,resetHandler);
}

class _ShowHistoryState extends State<ShowHistory>
{
  List _myList;
  List _Time;
  final int resultScore;
  final Function resetHandler;
  _ShowHistoryState(this._myList,this._Time,this.resultScore,this.resetHandler);
  _resetscreen() async
  {
    setState(() {
      _myList = ["Score"];
      _Time = ["Time"];
    });
  }
  _clearHistory() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    _resetscreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black,
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Color.fromRGBO(24, 22, 23, 1),
      ),
      body:       new Container(
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
                      children:[
                        Row(
                          children: [
                            Column(
                              children: _myList.map((value)
                              {
                                return Text("\t\t\t\t"+value+"\t\t\t\t\t\t\t",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),);
                                //Return an empty Container for non-matching case
                              }).toList(),
                            ),
                            Column(
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              children: _Time.map((value) {
                                return Text(value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),);
                                //Return an empty Container for non-matching case
                              }).toList(),
                            )
                          ],
                        ),
                        SizedBox(   //Use of SizedBox
                          height: 30,
                        ),
                        FlatButton(onPressed: _clearHistory, child: Text("Clear History",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),)),
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
/*
FlatButton(onPressed:()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Result(resultScore, resetHandler, _myList, _Time)));
                    }, child: Text("Back"))
 */

