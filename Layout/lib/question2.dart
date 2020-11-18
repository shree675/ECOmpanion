import 'package:flutter/material.dart';

class Question2 extends StatelessWidget {
  final String question;
  int index;
  Question2(this.question,this.index);
  @override
  Widget build(BuildContext context) {
    // print(index);
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
