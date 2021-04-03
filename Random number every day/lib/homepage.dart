import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int randomIndex;
  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  _setLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastOpenedTime", DateTime.now().toIso8601String());
  }

  _getLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpenedTimeString = prefs.getString("lastOpenedTime");
    if (lastOpenedTimeString == null) {
      return DateTime(2000);
    }
    return DateTime.parse(lastOpenedTimeString);
  }

  _generateRandomNumber() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime lastOpenedTime = await _getLastOpenedTime();
    print("$lastOpenedTime 2");
    if (lastOpenedTime
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      int randomIndex = Random().nextInt(10);
      /*
      String lastCardShownDateString = prefs.getString("lastShown" + randomIndex.toString())
      if(lastCardShownDateString == null){
        prefs.setString("lastShown" + randomIndex.toString(), DateTime.now().toIso8601String());
        lastCardShownDate = DateTime.parse(prefs.getString("lastShown" + randomIndex.toString()));
        return;
      }
      lastCardShownDate = DateTime.parse(lastCardShownDateString);
      */
      //while (!lastCardShownDate.isBefore(DateTime.now().subtract(Duration(days: flashcardModels[randomIndex].frequency)))){
      // randomIndex = Random().nextInt(flashcardModels.length);
      //}
      await prefs.setInt("randomIndex", randomIndex);
      int temp = prefs.getInt("randomIndex");
      if (temp != null) {
        setState(() {
          this.randomIndex = temp;
        });
      }
      print("random index generated successfully!");
    } else {
      int temp = prefs.getInt("randomIndex");
      if (temp != null) {
        setState(() {
          this.randomIndex = temp;
        });
      }
    }
    await _setLastOpenedTime();
    print("${prefs.getString("lastOpenedTime")} 1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$randomIndex"),
            FlatButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text("Read"),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
