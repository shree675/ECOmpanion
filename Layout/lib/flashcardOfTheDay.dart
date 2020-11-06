import 'dart:math';

import 'package:Layout/flashcard.dart';
import 'package:Layout/flashcard_model.dart';
import 'package:flutter/material.dart';

class FlashcardOfTheDay extends StatefulWidget {
  @override
  _FlashcardOfTheDayState createState() => _FlashcardOfTheDayState();
}

class _FlashcardOfTheDayState extends State<FlashcardOfTheDay> {
  int randomIndex = Random().nextInt(flashcardModels.length);
  @override
  Widget build(BuildContext context) {
    return Flashcard(flashcardModels[randomIndex]);
  }
}
