import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  final List<String> options;
  Question(this.question, this.options);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(question),
        ...options.map((e) {
          return FlatButton(
            onPressed: () {},
            child: Text(
              e,
            ),
          );
        })
      ],
    ));
  }
}
