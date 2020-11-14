import 'package:flutter/material.dart';
import 'flashcard_model.dart';
import 'flashcard.dart';

class FlashcardsScreen extends StatelessWidget {
  final int index;
  FlashcardsScreen(this.index);

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
              Icons.account_circle,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: flashcardModels.map((e) => Flashcard(e, index)).toList(),
        ),
      ),
    );
  }
}
