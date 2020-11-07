import 'package:Layout/homescreen.dart';
import 'package:Layout/selectedQuestions.dart';

import './question.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'flashcard_model.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  void answerChosen() {
    setState(() {
      currentQuestion += 1;
    });
  }

  List<Question> selectedQuestions = flashcardModels.map((e) {
    if (e.hasReminder) {
      return Question(
        e.question,
        e.options,
        data[flashcardModels.indexOf(e)],
        0,
        e,
      );
    }
  }).toList();

  @override
  Widget build(BuildContext context) {
    return currentQuestion < selectedQuestions.length
        ? Center(
            child: selectedQuestions[currentQuestion],
          )
        : HomeScreen();
  }
}
