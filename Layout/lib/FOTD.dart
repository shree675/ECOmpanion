import 'dart:math';

import 'package:flutter/material.dart';

import 'data.dart';
import 'environmentalDays_model.dart';
import 'flashcard_model.dart';

class FOTD extends StatefulWidget {
  @override
  _FOTDState createState() => _FOTDState();
}

class _FOTDState extends State<FOTD> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    for (var environmentalDay in environmentalDays) {
      if ((environmentalDay["date"] as Map)["month"] == today.month) {
        if ((environmentalDay["date"] as Map)["day"] == today.day) {
          return EnvironmentalDayCard(environmentalDay);
        }
      }
    }
    int randomIndex = Random().nextInt(flashcardModels.length);
    while (flashcardModels[randomIndex].lastShown.isBefore(DateTime.now()
        .subtract(Duration(days: flashcardModels[randomIndex].frequency)))) {
      randomIndex = Random().nextInt(flashcardModels.length);
    }
  }
}
