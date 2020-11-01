import './data.dart';
// import './models/flashcard.dart';
import 'package:flutter/material.dart';
import 'flashcard.dart';

class FlashcardsScreen extends StatelessWidget {
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
        children: data.map((e) => Flashcard(e)).toList(),
      ),
    );
  }
}