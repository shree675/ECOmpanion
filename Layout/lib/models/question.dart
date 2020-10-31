import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  final List<String> options;
  Question(this.question, this.options);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
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
              (e) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: const Color(0xff1B3671),
                  onPressed: () {},
                  child: Text(
                    e,
                    style: TextStyle(color: const Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
