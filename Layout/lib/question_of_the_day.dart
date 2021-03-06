import 'package:flutter/material.dart';

class QuestionOfTheDay extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function answer;
  QuestionOfTheDay(this.question, this.options, this.answer);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      width: MediaQuery.of(context).size.width - 5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        color: const Color(0xff1F4EB4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...options.map(
              (option) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: const Color(0xff1B3671),
                  onPressed: answer,
                  child: Text(
                    option,
                    style: TextStyle(color: const Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
