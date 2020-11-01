// import 'package:Layout/data.dart';
import 'package:flutter/material.dart';
import 'data.dart';
// import './models/question.dart';
import 'question.dart';

class DailyQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xff2C2E36,
      ),
      appBar: AppBar(
        title: Text("ECO"),
        centerTitle: true,
        backgroundColor: const Color(
          0xff2C2E36,
        ),
        elevation: 0,
      ),
      body: Column(
        children: data.map((e) {
          if (e["hasReminder"]) {
            return Question(
              e["question"],
              e["options"],
              e,
              1
            );
          }
          return SizedBox(
            height: 0,
            width: 0,
          );
        }).toList(),
      ),
    );
  }
}