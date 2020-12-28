import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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
  List<Widget> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  void _checkAnswer(bool selectedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      // Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      // Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
      // Step 4 Part B is in the quiz_brain.dart
      // Step 4 Part C - reset the questionNumber,
      // Step 4 Part D - empty out the scoreKeeper.

      // Step 5 - If we've not reached the end, ELSE do the answer checking steps below

      if (quizBrain.isFinished()) {
        // Alert has a default button "CANCEL" that close the alert
        Alert(
          context: context,
          title: "FINISHED",
          desc: "This is the end of the quiz!",
        ).show();

        // do this no matter what the user's input is
        quizBrain.resetQuiz();
        scoreKeeper.clear();
      } else {
        if (selectedAnswer == correctAnswer) {
          print('User was right!');
          scoreKeeper.add(Icon(
            Icons.check_rounded,
            color: Colors.green,
          ));
        } else {
          print('User was wrong!');
          scoreKeeper.add(Icon(
            Icons.close_rounded,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });

    //print("Is Finished: " + quizBrain.isFinished().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
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
                //The user picked true.
                _checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                _checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
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
