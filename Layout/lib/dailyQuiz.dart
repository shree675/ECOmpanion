import 'package:flutter/material.dart';
import 'data.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'question2.dart';
import 'options.dart';

class DailyQuiz extends StatefulWidget {
  final int curIndex;
  DailyQuiz(this.curIndex);

  @override
  _DailyQuizState createState() => _DailyQuizState(this.curIndex);
}

class _DailyQuizState extends State<DailyQuiz> {
  bool rem;
  int index, diff, id;
  bool daily;
  int curIndex = -1;

  answer() async {
    if (curIndex >= 50) {
      await answer2();
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
      return;
    }
    setState(() {
      curIndex += 1;
      if(curIndex>=50){
        answer();
        // return;
      }
      if (!data[curIndex]["isDaily"]) {
        answer();
      }
    });
  }

  answer2() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('takeq', DateTime.now().toIso8601String());
  }

  _DailyQuizState(this.curIndex);

  List<bool> ndeasyrem = new List(9);
  List<bool> ndmediumrem = new List(19);
  List<bool> ndhardrem = new List(12);

  List<bool> deasyrem = new List(2);
  List<bool> dmediumrem = new List(6);
  List<bool> dhardrem = new List(3);

  loadCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 9; i++) {
        ndeasyrem[i] = pre.getBool('easyrem$id') ?? false;
      }
      for (int i = 0; i < 19; i++) {
        ndmediumrem[i] = pre.getBool('mediumrem$id') ?? false;
      }
      for (int i = 0; i < 12; i++) {
        ndhardrem[i] = pre.getBool('hardrem$id') ?? false;
      }
      for (int i = 0; i < 2; i++) {
        deasyrem[i] = pre.getBool('deasyrem$id') ?? false;
      }
      for (int i = 0; i < 6; i++) {
        dmediumrem[i] = pre.getBool('dmediumrem$id') ?? false;
      }
      for (int i = 0; i < 3; i++) {
        dhardrem[i] = pre.getBool('dhardrem$id') ?? false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadCounter();
    answer();
  }

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
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          },
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
      body: curIndex < (data.length-1)
          ? Column(
        children: [
          Question2(data[curIndex]["question"]),
          ...(data[curIndex]["options"] as List)
              .map((e) => Option(answer, e, curIndex)),
        ],
      )
      //     : Center(
      //   child: RaisedButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => HomeScreen(),
      //           ));
      //     },
      //     child: Text("Reset"),
      //   ),
      // ),
      : SizedBox(height: 0, width: 0,),
    );
  }
}
