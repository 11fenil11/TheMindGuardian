import 'package:flutter/material.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

void main() => runApp(s1());

class s1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  static const routeName= '/main';



  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  final sentiment = Sentiment();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  var txt = TextEditingController();
  Text t1;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Twitter Sentiment Analysis',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(24, 22, 23, 1),
      ),
      body: Column(
        children: [
          new Container(
            padding: new EdgeInsets.fromLTRB(15,50,15,50),
            child: new Container(

              color: Color.fromRGBO(24, 22, 23, 1),
              child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: myController,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white,),
                      ),
//            child: TextField(
                    ),]
              ),),),
          FlatButton(onPressed:()
          {
            Map answer = sentiment.analysis(myController.text);
            String polarity;
            if(answer["score"]>0)
            {
              polarity = "Polarity : Positive\n";
            }
            else if(answer["score"]<0)
            {
              polarity = "Polarity : Negative\n";
            }
            else
            {
              polarity = "Polarity : Neutral\n";
            }
            polarity+=answer.toString();
            txt.text = polarity;
          },child: Text('Check',style:TextStyle(fontSize: 20.0),),
            color: Color.fromRGBO(17, 0, 255, 1),
            textColor: Colors.white,),
          Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child:Container(
                padding: new EdgeInsets.fromLTRB(15,50,15,50),
                child:Row(
                    children:<Widget>[
                      Flexible(
                          child: TextField(
                            controller:txt,
                            maxLines: 10,
                            style: TextStyle(color: Colors.white,),
                          )),
                    ]
                ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields,
          color: Color.fromRGBO(17, 0, 255, 1),),
      ),
    );
  }
}