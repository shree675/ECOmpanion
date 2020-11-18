import 'package:flutter/material.dart';

class Question2 extends StatelessWidget {
  final String question;
  final Color color;
  Question2(this.question, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              question,
              style: TextStyle(fontSize: 18, color: const Color(0xffFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }
}
