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

      appBar: AppBar(
        title: Text('Twitter Sentiment Analysis'),
      ),
      body: Column(
        children: [
          TextField(
            controller: myController,
          ),
          FlatButton(onPressed:()
          {
            Map answer = sentiment.analysis(myController.text);
            String polarity;
            if(answer["score"]>0)
            {
              polarity = "Polarity : Positive\t";
            }
            else if(answer["score"]<0)
            {
              polarity = "Polarity : Negative\t";
            }
            else
            {
              polarity = "Polarity : Neutral\t";
            }
            polarity+=answer.toString();
            txt.text = polarity;
          }, child: Text('Check',style:TextStyle(fontSize: 20.0),),
            color: Colors.blueAccent,
            textColor: Colors.white,),
          TextField(
            controller:txt,
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
        child: Icon(Icons.text_fields),
      ),
    );
  }
}