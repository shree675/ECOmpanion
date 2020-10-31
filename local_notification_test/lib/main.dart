import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// edit notification help to chose between quiz page and home page - line 42 of noyify_help
// edit notification help for displaying notification - line 92 of noyify_help
// edit custom notification period duration to 24 hours - line 118 of custom_noti