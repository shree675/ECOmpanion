import 'package:flutter/material.dart';
import 'share_pref.dart';
import 'custom_noti.dart';
import 'time_select.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TimeOfDay t = TimeOfDay.now();

  @override
  void initState() {
    //time_select(t);
    super.initState();
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, t.hour, t.minute); // eg 7 AM
    var endTime = DateTime(now.year, now.month, now.day, t.hour, t.minute + 10); // eg 10 PM
    setStartTime(startTime);
    setEndTime(endTime);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CustomizedNotification();
              }));
            },
            child: Container(
              height: 60,
              width: 100,
              child: Icon(
                Icons.alarm,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return time_select(t);
              }));
            },
            child: Container(
              height: 60,
              width: 100,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
