import 'package:flutter/material.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/quiz.dart';
import 'package:firebase_login/Old Project/Features/MAIN_CONTENT/Quiz/result.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyQuiz());

class MyQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyQuizState();
  }
}

class _MyQuizState extends State<MyQuiz>
{
  int _counter = 0;
  List<String> _myList=["Score"];
  List<String> _Time = ["Time"];
  @override
  void initState()
  {
    super.initState();
    _loadCounter();
  }
  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _myList = (prefs.getStringList('myList')??["Score"]);
      _Time = (prefs.getStringList('Time')??["Time"]);
    });
  }
  _resetscreen()
  {
    setState(() {
      _myList = ["Score"];
      _Time = ["Time"];
    });
  }

  final List _given_answers = [-1,-1,-1,-1,-1,-1,-1,-1,-1];
  final _questions = const
  [
    {
      'questionText': '(1) Over last two weeks, how often have you been bothered by Little interest '
          'or pleasure in doing things ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (2) Over last two weeks, how often have you been bothered by Feeling down, depressed '
          'or hopeless ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (3) Over last two weeks, how often have you been bothered by Trouble falling '
          'or staying asleep, or sleeping too much?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (4) Over last two weeks, how often have you been bothered by feeling tired '
          'or having little energy ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (5) Over last two weeks, how often have you been bothered by Poor appetite or '
          'overeating ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (6) Over last two weeks, how often have you been bothered by feeling bad '
          'about yourself - or that you are a failure or have let yourself or your family down ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (7) Over last two weeks, how often have you been bothered by '
          'Trouble concentrating on things, such as reading the newspaper or watching television ?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (8) Over last two weeks, how often have you been bothered by Moving or '
          'speaking noticeably slower than usual or the opposite - faster than usual?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
    {
      'questionText': ' (9) Over last two weeks, how often have you been bothered by Thoughts '
          'that you would be better off dead or of hurting yourself in some way?',
      'answers': [
        {'text': 'Not at all', 'score': 0},
        {'text': 'Very few days', 'score': 1},
        {'text': 'More than half days', 'score': 2},
        {'text': 'Nearly every day', 'score': 3},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      //_addvalues(_totalScore);
      _questionIndex = 0;
      _totalScore = 0;
      once = true;
      for(int i=0;i<_given_answers.length;i++)
        {
          _given_answers[i] = -1;
        }
    });
  }
  bool once = true;
  _addvalues(int sc) async {
    while(once)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          _myList = (prefs.getStringList('myList')??["Score"]);
          _Time = (prefs.getStringList('Time')??["Time"]);
          _myList.add(sc.toString());
          _Time.add(DateTime.now().toString().substring(0,19));
          prefs.setStringList('myList', _myList);
          prefs.setStringList('Time',_Time);
          setState(() {
            once = false;
          });
        });
      }
  }
  void _prevIndex()
  {
    setState(() {
      if(_questionIndex>0)
      {
        _questionIndex = _questionIndex - 1;
      }
    });
  }
  void _nextIndex()
  {
    setState(() {
      if(_questionIndex<_questions.length-1)
      {
        _questionIndex = _questionIndex+1;
      }
    });
  }
  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;
    _totalScore += score;
    setState(() {
      if(_given_answers[_questionIndex]>=0)
        {
          _totalScore-=_given_answers[_questionIndex];
        }
      _given_answers[_questionIndex] = score;
      if(_questionIndex<_questions.length)
        {
          _questionIndex = _questionIndex + 1;
        }
    });

    /*  print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = const ['Hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
    // questions = []; // does not work if questions is a const
    var get_index = '';
    if(_questionIndex >=0 && _questionIndex<_questions.length)
      {
          if(_given_answers[_questionIndex] == 0)
          {
            get_index = 'A';
          }
          else if(_given_answers[_questionIndex] == 1)
          {
            get_index = 'B';
          }
          else if(_given_answers[_questionIndex] == 2)
          {
            get_index = 'C';
          }
          else if(_given_answers[_questionIndex] == 3)
          {
            get_index = 'D';
          }
      }
    bool _check_each = true;
    for(int i=0;i<_questions.length-1;i++)
      {
        if(_given_answers[i] == -1)
          {
            _check_each = false;
            break;
          }
      }
    // print("check_each : $_check_each");
    // print("question index : $_questionIndex");
    if((_check_each == true) && (_questionIndex == _questions.length))
      {
        // print("In condition!");
        _addvalues(_totalScore);
//        _check_each = false;
      }
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Quiz Application'),
          backgroundColor: Color.fromRGBO(24, 22, 23, 1),
        ),
        body:
        Container(
          child:new Column(
            children: [
              (_questionIndex<_questions.length) ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              ):
              (_check_each == true)?(Result(_totalScore, _resetQuiz,_myList,_Time)): //[(Result(_totalScore, _resetQuiz)),_addvalues()]
                Column(
                    children: [
                      Quiz(
                        answerQuestion: _answerQuestion,
                        questionIndex: _questionIndex-1,
                        questions: _questions,
                      ),
                      Text("You have not attempted each and every answer",
                        style: TextStyle(color: Colors.white),),
                      FlatButton(onPressed:_prevIndex,child:
                      Text("Previous",
                        style: TextStyle(color: Colors.white),),),
                      FlatButton(onPressed:_nextIndex, child:
                      Text("Next",
                        style: TextStyle(color: Colors.white),),),
                    ],
                  ),
              SizedBox(   //Use of SizedBox
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _questionIndex<_questions.length? FlatButton(onPressed:_prevIndex,child:
                  Text("Previous", style: TextStyle(color: Colors.white,fontSize: 20),),): Text(""),
                  _questionIndex<_questions.length?FlatButton(onPressed:_nextIndex, child:
                  Text("Next",style: TextStyle(color: Colors.white,fontSize: 20),),):Text(""),
                ],
              ),
              SizedBox(   //Use of SizedBox
                height: 50,
              ),
              (_questionIndex>=0 && _questionIndex<_questions.length)?
              (_given_answers[_questionIndex]>=0?Text(
                "Attempted answer on this question : "+get_index,
                style: TextStyle(
                  color: Colors.white,
                ),
              ):Text("")):Text(""),
            ],
          )
        ),
        )
    );
  }
}