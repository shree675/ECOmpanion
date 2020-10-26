import 'package:flutter/material.dart';
import 'facts_list3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ECOmpanion"),
          backgroundColor: Colors.green,
        ),
        body: FactsList3(),
      ),
    );
  }
}
