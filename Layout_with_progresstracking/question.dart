import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question extends StatefulWidget {
  final String question;
  final List<String> options;
  Map<String, Object> data;
  int quiz;
  Question(this.question, this.options, this.data, this.quiz);

  @override
  _QuestionState createState() =>
      _QuestionState(this.question, this.options, this.data, this.quiz);
}

class _QuestionState extends State<Question> {
  final String question;
  final List<String> options;
  Map<String, Object> data;

  int id;
  int diff;
  bool daily, level;
  int quiz;

  _QuestionState(this.question, this.options, this.data, this.quiz);
  List<int> ndeasy = new List(8);
  List<String> easystring = new List(8);
  List<int> ndmedium = new List(19);
  List<String> mediumstring = new List(19);
  List<int> ndhard = new List(12);
  List<String> hardstring = new List(12);

  List<int> deasy = new List(2);
  List<String> deasystring = new List(2);
  List<int> dmedium = new List(6);
  List<String> dmediumstring = new List(6);
  List<int> dhard = new List(3);
  List<String> dhardstring = new List(3);

  // List<SvgPicture> badges;
  int levelChange = 0;
  String badgeName;
  int curLevel = 0;
  int numOfOptions;

  @override
  initState() {
    super.initState();
    id = data["id"];
    id -= 1;
    diff = (this.data["difficulty"] as Map)["scale"];
    daily = this.data["isDaily"];
    level = this.data["hasLevel"];
    // badges=this.data["badges"];
    badgeName = (this.data["badge"] as Map)["name"];
    badgeName = badgeName.toUpperCase();
    numOfOptions = (this.data["options"] as List).length;

    if (!daily) {
      if (diff == 1) {
        ndeasy[id] = 1;
        easystring[id] = "easy$id";
      } else if (diff == 2) {
        ndmedium[id] = 1;
        mediumstring[id] = "medium$id";
      } else if (diff == 3) {
        ndhard[id] = 1;
        hardstring[id] = "hard$id";
      }
    }
    // else if(daily && quiz==1){
    else if (daily) {
      if (diff == 1) {
        deasy[id] = 1;
        deasystring[id] = "deasy$id";
      } else if (diff == 2) {
        dmedium[id] = 1;
        dmediumstring[id] = "dmedium$id";
      } else if (diff == 3) {
        dhard[id] = 1;
        dhardstring[id] = "dhard$id";
      }
    }
    loadCounter(diff, id);
    // resetCounter();
  }

  loadCounter(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasy[id] = pre.getInt('easy$id') ?? 1;
          curLevel = ndeasy[id];
        } else if (diff == 2) {
          ndmedium[id] = pre.getInt('medium$id') ?? 1;
          curLevel = ndmedium[id];
        } else if (diff == 3) {
          ndhard[id] = pre.getInt('hard$id') ?? 1;
          curLevel = ndhard[id];
        }
      }
      // else if(daily && quiz==1){
      else if (daily) {
        if (diff == 1) {
          deasy[id] = pre.getInt('deasy$id') ?? 1;
          curLevel = deasy[id];
        } else if (diff == 2) {
          dmedium[id] = pre.getInt('dmedium$id') ?? 1;
          curLevel = dmedium[id];
        } else if (diff == 3) {
          dhard[id] = pre.getInt('dhard$id') ?? 1;
          curLevel = dhard[id];
        }
      }
    });
  }

  validate() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    if (!daily) {
      if (diff == 1) {
        if (ndeasy[id] < 1) {
          ndeasy[id] = (pre.getInt('easy$id') ?? 1);
          ndeasy[id] = 1;
          pre.setInt('easy$id', ndeasy[id]);
        } else if (ndeasy[id] > 51) {
          ndeasy[id] = (pre.getInt('easy$id') ?? 1);
          ndeasy[id] = 51;
          pre.setInt('easy$id', ndeasy[id]);
        }
      } else if (diff == 2) {
        if (ndmedium[id] < 1) {
          ndmedium[id] = (pre.getInt('medium$id') ?? 1);
          ndmedium[id] = 1;
          pre.setInt('medium$id', ndmedium[id]);
        }
        if (ndmedium[id] > 34) {
          ndmedium[id] = (pre.getInt('medium$id') ?? 1);
          ndmedium[id] = 34;
          pre.setInt('medium$id', ndmedium[id]);
        }
      } else if (diff == 3) {
        if (ndhard[id] < 1) {
          ndhard[id] = (pre.getInt('hard$id') ?? 1);
          ndhard[id] = 1;
          pre.setInt('hard$id', ndhard[id]);
        }
        if (ndhard[id] > 17) {
          ndhard[id] = (pre.getInt('hard$id') ?? 1);
          ndhard[id] = 17;
          pre.setInt('hard$id', ndhard[id]);
        }
      }
    }
    // else if(daily && quiz==1){
    else if (daily) {
      if (diff == 1) {
        if (deasy[id] < 1) {
          deasy[id] = (pre.getInt('deasy$id') ?? 1);
          deasy[id] = 1;
          pre.setInt('deasy$id', deasy[id]);
        } else if (deasy[id] > 377) {
          deasy[id] = (pre.getInt('deasy$id') ?? 1);
          deasy[id] = 377;
          pre.setInt('deasy$id', deasy[id]);
        }
      } else if (diff == 2) {
        if (dmedium[id] < 1) {
          dmedium[id] = (pre.getInt('dmedium$id') ?? 1);
          dmedium[id] = 1;
          pre.setInt('dmedium$id', dmedium[id]);
        } else if (dmedium[id] > 257) {
          dmedium[id] = (pre.getInt('dmedium$id') ?? 1);
          dmedium[id] = 257;
          pre.setInt('dmedium$id', dmedium[id]);
        }
      } else if (diff == 3) {
        if (dhard[id] < 1) {
          dhard[id] = (pre.getInt('dhard$id') ?? 1);
          dhard[id] = 1;
          pre.setInt('dhard$id', dhard[id]);
        } else if (dhard[id] > 137) {
          dhard[id] = (pre.getInt('dhard$id') ?? 1);
          dhard[id] = 137;
          pre.setInt('dhard$id', dhard[id]);
        }
      }
    }
  }

  updateCounter(int i, int points) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasy[i] = (pre.getInt('easy$i') ?? 1) + points;
          pre.setInt('easy$i', ndeasy[i]);
          curLevel = ndeasy[id];
          if (points == 1 && ndeasy[i] ~/ 3 > (ndeasy[i] - 1) ~/ 3) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 2) {
          ndmedium[i] = (pre.getInt('medium$i') ?? 1) + points;
          pre.setInt('medium$i', ndmedium[i]);
          curLevel = ndmedium[id];
          if (points == 1 && ndmedium[i] ~/ 2 > (ndmedium[i] - 1) ~/ 2) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 3) {
          ndhard[i] = (pre.getInt('hard$i') ?? 1) + points;
          pre.setInt('hard$i', ndhard[i]);
          curLevel = ndhard[id];
          if (points == 1) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
      }
      // else if(daily && quiz==1){
      else if (daily) {
        if (diff == 1) {
          deasy[i] = (pre.getInt('deasy$i') ?? 1) + points;
          pre.setInt('deasy$i', deasy[i]);
          curLevel = deasy[id];
          if (points == 1 &&
              getLevel(1, deasy[i], daily) >
                  (getLevel(1, deasy[i] - 1, daily))) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 2) {
          dmedium[i] = (pre.getInt('dmedium$i') ?? 1) + points;
          pre.setInt('dmedium$i', dmedium[i]);
          curLevel = dmedium[id];
          if (points == 1 &&
              getLevel(2, dmedium[i], daily) >
                  (getLevel(2, dmedium[i] - 1, daily))) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 3) {
          dhard[i] = (pre.getInt('dhard$i') ?? 1) + points;
          pre.setInt('dhard$i', dhard[i]);
          curLevel = dhard[id];
          if (points == 1 &&
              getLevel(3, dhard[i], daily) >
                  (getLevel(3, dhard[i] - 1, daily))) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
      }
    });
    validate();
  }

  resetCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    for (int i = 0; i < 8; i++) {
      pre.setInt('easy$i', 1);
    }
    for (int i = 0; i < 19; i++) {
      pre.setInt('medium$i', 1);
    }
    for (int i = 0; i < 12; i++) {
      pre.setInt('hard$i', 1);
    }
    for (int i = 0; i < 2; i++) {
      pre.setInt('deasy$i', 1);
    }
    for (int i = 0; i < 6; i++) {
      pre.setInt('dmedium$i', 1);
    }
    for (int i = 0; i < 3; i++) {
      pre.setInt('dhard$i', 1);
    }
  }

  int getLevel(int d, int an, bool isdaily) {
    if (isdaily) {
      if (d == 1) {
        return ((7 + sqrt(24 * an - 23)) / 6).floor().toInt();
      } else if (d == 2) {
        return (1 + sqrt(an - 1)).floor().toInt();
      } else {
        return ((1 + sqrt(8 * an - 7)) / 2).floor().toInt();
      }
    } else {
      if (d == 1) {
        return an ~/ 3;
      } else if (d == 2) {
        return an ~/ 2;
      } else if (d == 3) {
        return (an).toInt();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      width: MediaQuery.of(context).size.width - 5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        color: const Color(0xff1F4EB4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Text(
                widget.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...widget.options.map(
              (e) => Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  color: const Color(0xff1B3671),
                  onPressed: () async {
                    if (numOfOptions == 2) {
                      if (e == (data["options"] as List)[0] && level) {
                        await updateCounter(id, 1);
                      } else if (e == (data["options"] as List)[1] && level) {
                        await updateCounter(id, -1);
                      }
                    } else if (numOfOptions == 3) {
                      if (e == (data["options"] as List)[0] && level) {
                        await updateCounter(id, 1);
                      } else if (e == (data["options"] as List)[2] && level) {
                        await updateCounter(id, -1);
                      }
                    } else if (numOfOptions == 4) {}

                    if (this.levelChange == 1) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 430.0,
                              color: Color(0xff2c2e36),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 170.0,
                                    ), // here goes the svg
                                    Center(
                                      child: Text(
                                        'CONGRATULATIONS!\n',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Center(
                                      child: Text(
                                        'You earned',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Center(
                                      child: Text(
                                        '$badgeName!',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Center(
                                      child: Text(
                                        'LEVEL ${getLevel(diff, curLevel, daily)}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
                  child: Text(
                    e,
                    style: TextStyle(color: const Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}