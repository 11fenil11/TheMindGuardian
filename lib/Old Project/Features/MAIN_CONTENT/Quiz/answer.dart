import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Color.fromRGBO(17,0,255,1),
        textColor: Colors.white,
        child: Text(answerText,
          style: TextStyle(fontSize: 18),),
        onPressed: selectHandler,
      ),
    );
  }
}
