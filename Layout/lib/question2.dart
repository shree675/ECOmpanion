import 'package:flutter/material.dart';

class Question2 extends StatelessWidget {
  final String question;
  Question2(this.question);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question),
          ),
        ),
      ),
    );
  }
}