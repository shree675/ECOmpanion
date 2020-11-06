import 'dart:math';
import 'package:Layout/flashcard.dart';
import 'package:Layout/question.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class FlashcardOfTheDay extends StatefulWidget {
  @override
  _FlashcardOfTheDayState createState() => _FlashcardOfTheDayState();
}

class _FlashcardOfTheDayState extends State<FlashcardOfTheDay> {
  int randomIndex = 0;

  @override
  Widget build(BuildContext context) {
    if ((data[randomIndex]["lastShown"] as DateTime)
        .isBefore(DateTime.now().subtract(new Duration(
      days: data[randomIndex]["frequency"],
    )))) {
      if ((data[randomIndex]["timeAnswered"] as DateTime)
          .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        print(data[randomIndex]["timeAnswered"]);
        return Question(
          data[randomIndex]["question"],
          data[randomIndex]["options"],
          data[randomIndex],
          1,
        );
      }
      return Flashcard(data[randomIndex]);
    }
    return Container(
      width: 0,
      height: 0,
    );
  }
}
