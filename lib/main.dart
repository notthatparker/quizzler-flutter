import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int inum = 0;
  int corin = 0;
  List<Icon> scoreKeeper = [];
  QuizBrain quizBraini = QuizBrain();

  void inumchange() {
    if (inum < 11) {
      inum++;
    } else
      inum = 0;
  }

  void totreset() {
    quizBraini.reset();
    scoreKeeper = [];
  }

  void checkans(bool userp) {
    bool correctAns = quizBraini.getQuestionAns();

    setState(() {
      if (quizBraini.end == false) {
        if (userp == correctAns) {
          // print('that boy smart');
          scoreKeeper.add(
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          );
          corin++;
        } else {
          print('that boy dumb');
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          inum++;
        }
      } else {
        _onAlertWithCustomContentPressed(context, corin, inum);
        totreset();
      }
      quizBraini.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBraini.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        //button 1
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60.0)),
              splashColor: Colors.green[900],
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkans(true);

                //The user picked true.
              },
            ),
          ),
        ),

        //button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60.0)),
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkans(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Card(
          elevation: 0.0,
          color: Colors.cyan[100],
          margin: EdgeInsets.symmetric(horizontal: 2.0),
         // shape: ShapeBorder(BorderRadius.all(20)),
         
          child: Row(
         //   crossAxisAlignment: CrossAxisAlignment.stretch,
           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: scoreKeeper,
          ),
          
       
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
//alert dialog basic

//alert custom
_onAlertWithCustomContentPressed(context, int cor, int inum) {
  Alert(
      context: context,
      title: "Well Done",
      content: Column(
        children: <Widget>[
          Text(
            'Correct: $cor',
            style: TextStyle(color: Colors.green),
          ),
          Text(
            'Wrong: $inum',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
