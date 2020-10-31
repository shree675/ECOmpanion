import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'share_pref.dart';

class time_select extends StatelessWidget {

  TimeOfDay _time; // = TimeOfDay.now();
  time_select(this._time);

  void onTimeChanged(TimeOfDay newTime) {
    _time = newTime;
    var now = DateTime.now();
    setStartTime(DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute));
    setEndTime(
        DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute + 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _time.format(context),
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }

}