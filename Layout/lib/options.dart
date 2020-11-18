import 'package:flutter/material.dart';
import 'data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class Option extends StatefulWidget {
  final Function answer;
  final String option;
  int index;
  Option(this.answer, this.option, this.index);

  @override
  _OptionState createState() => _OptionState(this.answer, this.option, this.index);
}

class _OptionState extends State<Option> {

  final Function answer;
  final String option;
  int index;
  _OptionState(this.answer, this.option, this.index);

  List<int> deasy = new List(2);
  List<String> deasystring = new List(2);
  List<int> dmedium = new List(6);
  List<String> dmediumstring = new List(6);
  List<int> dhard = new List(3);
  List<String> dhardstring = new List(3);

  int id,diff;
  bool daily=true;
  int numOfOptions;
  bool level;
  String badgeName;
  List<String> badges;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=data[widget.index]["id"];
    id-=1;
    // index+=1;
    diff=(data[widget.index]["difficulty"] as Map)["scale"];
    level = true;
    badges = ((data[widget.index]["badge"] as Map)["path"] as List);
    badgeName = (data[widget.index]["badge"] as Map)["name"];
    badgeName = badgeName.toUpperCase();
    numOfOptions = (data[widget.index]["options"] as List).length;
      if (diff == 1) {
        deasy[id] = 0;
        deasystring[id] = "deasy$id";
      } else if (diff == 2) {
        dmedium[id] = 0;
        dmediumstring[id] = "dmedium$id";
      } else if (diff == 3) {
        dhard[id] = 0;
        dhardstring[id] = "dhard$id";
      }

    loadCounter(diff, id);
      // resetCounter();                                                             // remove this later
  }

  int curLevel;

  loadCounter(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      for(int i=0;i<2;i++){
        deasy[i]=pre.getInt('deasy$i') ?? 0;
      }
      for(int i=0;i<6;i++){
        dmedium[i]=pre.getInt('dmedium$i') ?? 0;
      }
      for(int i=0;i<3;i++){
        dhard[i]=pre.getInt('dhard$i') ?? 0;
      }
    });
  }

  validate(int id,int diff) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
      if (diff == 1) {
        if (deasy[id] < 0) {
          deasy[id] = (pre.getInt('deasy$id') ?? 0);
          deasy[id] = 0;
          pre.setInt('deasy$id', deasy[id]);
        } else if (deasy[id] > 377) {
          deasy[id] = (pre.getInt('deasy$id') ?? 0);
          deasy[id] = 377;
          pre.setInt('deasy$id', deasy[id]);
        }
      } else if (diff == 2) {
        if (dmedium[id] < 0) {
          dmedium[id] = (pre.getInt('dmedium$id') ?? 0);
          dmedium[id] = 0;
          pre.setInt('dmedium$id', dmedium[id]);
        } else if (dmedium[id] > 257) {
          dmedium[id] = (pre.getInt('dmedium$id') ?? 0);
          dmedium[id] = 257;
          pre.setInt('dmedium$id', dmedium[id]);
        }
      } else if (diff == 3) {
        if (dhard[id] < 0) {
          dhard[id] = (pre.getInt('dhard$id') ?? 0);
          dhard[id] = 0;
          pre.setInt('dhard$id', dhard[id]);
        } else if (dhard[id] > 137) {
          dhard[id] = (pre.getInt('dhard$id') ?? 0);
          dhard[id] = 137;
          pre.setInt('dhard$id', dhard[id]);
        }
      }

  }

  int levelChange=0;

  updateCounter(int i,int diff, int points) async {
    i-=1;
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
          if (diff == 1) {
          deasy[i] = (pre.getInt('deasy$i') ?? 0) + points;
          validate(i,diff);
          pre.setInt('deasy$i', deasy[i]);
          curLevel = deasy[i];
          if (points == 1 &&
              getLevel(1, deasy[i], daily) >
                  (getLevel(1, deasy[i] - 1, daily)) &&
              deasy[i] <= 377) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
          else if (diff == 2) {
          dmedium[i] = (pre.getInt('dmedium$i') ?? 0) + points;
          validate(i,diff);
          pre.setInt('dmedium$i', dmedium[i]);
          curLevel = dmedium[i];
          if (points == 1 &&
              getLevel(2, dmedium[i], daily) >
                  (getLevel(2, dmedium[i] - 1, daily)) &&
              dmedium[i] <= 257) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
          else if (diff == 3) {
          dhard[i] = (pre.getInt('dhard$i') ?? 0) + points;
          validate(i,diff);
          pre.setInt('dhard$i', dhard[i]);
          curLevel = dhard[i];
          if (points == 1 &&
              getLevel(3, dhard[i], daily) >
                  (getLevel(3, dhard[i] - 1, daily)) &&
              dhard[i] <= 137) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
        validate(i,diff);
    });
  }

  resetCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    for (int i = 0; i < 2; i++) {
      pre.setInt('deasy$i', 0);
    }
    for (int i = 0; i < 6; i++) {
      pre.setInt('dmedium$i', 0);
    }
    for (int i = 0; i < 3; i++) {
      pre.setInt('dhard$i', 0);
    }
  }

  int getLevel(int d, int an, bool isdaily) {
    if (an <= 0) {
      return 0;
    } else if (isdaily) {
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
    print(widget.index);
    badges = ((data[widget.index]["badge"] as Map)["path"] as List);
    badgeName = (data[widget.index]["badge"] as Map)["name"];
    badgeName = badgeName.toUpperCase();
    int i=data[widget.index]["id"];
    i-=1;
    if (diff == 1) {
      curLevel = deasy[i];
    }
    else if (diff == 2) {
      curLevel = dmedium[i];
    }
    else if (diff == 3) {
      curLevel = dhard[i];
    }

    return RaisedButton(
      onPressed: () async {
        int cur;
        if(widget.option==(data[widget.index]["options"] as List)[0] && level){
          await updateCounter(data[widget.index]["id"],(data[widget.index]["difficulty"] as Map)["scale"] ,1);
        }

        if (this.levelChange == 1) {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 400.0,
                  color: Color(0xffe5e5e5),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            '${badges[getLevel((data[widget.index]["difficulty"] as Map)["scale"], curLevel, daily)]}',
                            height: 140,
                            width: 140,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            'CONGRATULATIONS!',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
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
                              color: Colors.black,
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            'LEVEL ${getLevel((data[widget.index]["difficulty"] as Map)["scale"], curLevel, daily)}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
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
        await answer();
        },
      child: Center(
        child: Text(widget.option+' $curLevel ${widget.index}'),
      ),
    );
  }
}
