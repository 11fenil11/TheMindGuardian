import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';

class AlertBox {
  BuildContext context;
  String title;
  String content;
  List<Widget> actions;

  AlertBox(
    this.context,
    this.title,
    this.content,
    this.actions
  );

  showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: kPrimaryLightColor,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: 12,),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}