import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/history.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final List _myList;
  final List _Time;
  Result(this.resultScore, this.resetHandler,this._myList,this._Time);
  String get resultPhrase {
    String resultText;
    if (resultScore >= 0 && resultScore<=4) {
      resultText = 'You are completely depression free';
    } else if (resultScore <= 9) {
      resultText = 'You have mild level of depression';
    } else if (resultScore <= 14) {
      resultText = 'You have moderate depression symptoms';
    } else if (resultScore <= 19){
      resultText = 'You have moderately severe level of depression';
    } else
    {
      resultText = 'You have severe depression';
    }
    resultText+="\n\n\n";
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    String s = '\n\n Your score : ';
    s += resultScore.toString();
    s += "\n\n";
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            s,
            style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          new Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child:FlatButton(
              onPressed:resetHandler,
              child: Text("RESTART QUIZ", style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
          ),
          SizedBox(   //Use of SizedBox
            height: 50,
          ),
          new Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child:FlatButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowHistory(_myList,_Time,resultScore,resetHandler)),);
              },
              child: Text("CHECK HISTORY", style: TextStyle(color: Colors.white, fontSize: 15),),
            ),
          ),
        ],
      ),
    );
  }
}
