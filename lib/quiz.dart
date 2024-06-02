import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

const Color firstColor = Colors.deepPurple;
const Color secondColor = Color.fromARGB(255, 209, 148, 225);

const String headerImage = "assets/images/quiz-logo.png";

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);

    super.initState();
  }

  void resetQuestion() {
    setState(() {
      selectedAnswers = [];

      activeScreen = QuestionScreen(
        chooseAnswer: chooseAnswer,
      );
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          onRestart: resetQuestion,
          chosenAnswers: selectedAnswers,
        );
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(
        chooseAnswer: chooseAnswer,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                firstColor,
                secondColor,
              ],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
