import 'package:Layout/flashcard_model.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'question.dart';

class DailyQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xff2C2E36,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("ECO"),
        centerTitle: true,
        backgroundColor: const Color(
          0xff2C2E36,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: flashcardModels.map((e) {
            if (e.hasReminder) {
              return Question(e.question, e.options,
                  data[flashcardModels.indexOf(e)], 1, e);
            }
            return SizedBox(
              height: 0,
              width: 0,
            );
          }).toList(),
        ),
      ),
    );
  }
}
