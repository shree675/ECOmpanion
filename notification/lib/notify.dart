import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import'Quiz_potral.dart';

class notify extends StatefulWidget{
  notify ({Key key}) : super(key: key);

  @override
  _notifyState createState() => _notifyState();
}


class _notifyState extends State<notify>
{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //final NotificationManager notificationManager = NotificationManager();
  TimeOfDay _time = TimeOfDay.now();
  var h = TimeOfDay.now().hour;
  var m = TimeOfDay.now().minute;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
      h = newTime.hour;
      m = newTime.minute;
    });
  }
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload)  {
    debugPrint("payload : $payload");
    var x=1;
    // x = no of daily notifications selected 
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
    if(x!=0) {
      print('Notification clicked');
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => quiz()),
        // directed to quiz portal
      );
    }
    else
    {
      print('Notification clicked');
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => quiz()),
        // directed to homescreen to home screen
      );
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Local Notification'),
      ),
      body: Column(
        children: [
          FlatButton(
            color: Theme
                .of(context)
                .accentColor,
            onPressed: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _time,
                  onChange: onTimeChanged,
                  // Optional onChange to receive value as DateTime
                  onChangeDateTime: (DateTime dateTime) {
                    print(dateTime);
                  },
                ),
              );
            },
            child: Text(
              "Open time picker",
              style: TextStyle(color: Colors.white),
            ),
          ),
          new RaisedButton(

            onPressed:showNotification,

            child: Text("notify me on above fixed time"),

          ),
        ],
      ),
    );
  }
  showNotification() async {
    var time = new Time(h, m, 0);
    print(time);
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high,importance: Importance.max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    //await flutterLocalNotificationsPlugin.show(0, 'New Tutorial', 'Local Notification', platform,payload: 'AndroidCoding.in');
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.showDailyAtTime(0, 'data1.title', 'data1.body', time, platform,payload: 'welcome');
    // data1. is data to be printed on notification
  }
}
