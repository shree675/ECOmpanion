import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';

class Expanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ExpansionCard(
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Fact 1",
              ),
              Text(
                "Sub 1",
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: Text(
              "Content goes over here !",
            ),
          ),
        ],
      ),
    );
  }
}
