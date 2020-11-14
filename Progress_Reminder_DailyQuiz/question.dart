import 'dart:math';
// import 'package:Layout/flashcard_model.dart';
import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question extends StatefulWidget {
  final String question;
  final List<String> options;
  Map<String, Object> data;
  final FlashcardModel flashcardModel;
  int quiz;
  int index;
  Question(this.question, this.options, this.data, this.quiz,
      this.flashcardModel, this.index);

  int curIndex = 0;

  @override
  _QuestionState createState() => _QuestionState(this.question, this.options,
      this.data, this.quiz, this.flashcardModel, this.index);
}

class _QuestionState extends State<Question> {
  final String question;
  final List<String> options;
  Map<String, Object> data;
  final FlashcardModel flashcardModel;

  int id;
  int diff;
  bool daily, level;
  int quiz;
  int index;

  _QuestionState(this.question, this.options, this.data, this.quiz,
      this.flashcardModel, this.index);
  List<int> ndeasy = new List(9);
  List<String> easystring = new List(9);
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

  List<String> badges;
  int levelChange = 0;
  String badgeName;
  int curLevel = 0;
  int numOfOptions;

  @override
  initState() {
    super.initState();
    id = this.data["id"];
    id -= 1;
    diff = (this.data["difficulty"] as Map)["scale"];
    daily = this.data["isDaily"];
    level = this.data["hasLevel"];
    badges = ((this.data["badge"] as Map)["path"] as List);
    badgeName = (this.data["badge"] as Map)["name"];
    badgeName = badgeName.toUpperCase();
    numOfOptions = (this.data["options"] as List).length;

    if (!daily) {
      if (diff == 1) {
        ndeasy[id] = 0;
        easystring[id] = "easy$id";
      } else if (diff == 2) {
        ndmedium[id] = 0;
        mediumstring[id] = "medium$id";
      } else if (diff == 3) {
        ndhard[id] = 0;
        hardstring[id] = "hard$id";
      }
    }
    // } else if (daily && quiz == 1) {
    else if (daily) {
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
    }
    loadCounter(diff, id);
    loadCounter2(diff, id);
    // resetCounter();
  }

  bool rem;

  loadCounter2(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          this.rem = pre.getBool('easyrem$id') ?? false;
        } else if (diff == 2) {
          this.rem = pre.getBool('mediumrem$id') ?? false;
        } else if (diff == 3) {
          this.rem = pre.getBool('hardrem$id') ?? false;
        }
      } else {
        if (diff == 1) {
          this.rem = pre.getBool('deasyrem$id') ?? false;
        } else if (diff == 2) {
          this.rem = pre.getBool('dmediumrem$id') ?? false;
        } else if (diff == 3) {
          this.rem = pre.getBool('dhardrem$id') ?? false;
        }
      }
    });
  }

  loadCounter(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasy[id] = pre.getInt('easy$id') ?? 0;
          this.data["currentLevel"] = ndeasy[id];
          curLevel = ndeasy[id];
        } else if (diff == 2) {
          ndmedium[id] = pre.getInt('medium$id') ?? 0;
          this.data["currentLevel"] = ndmedium[id];
          curLevel = ndmedium[id];
        } else if (diff == 3) {
          ndhard[id] = pre.getInt('hard$id') ?? 0;
          this.data["currentLevel"] = ndhard[id];
          curLevel = ndhard[id];
        }
      } else if (daily && quiz == 1) {
        // else if (daily) {
        if (diff == 1) {
          deasy[id] = pre.getInt('deasy$id') ?? 0;
          this.data["currentLevel"] = deasy[id];
          curLevel = deasy[id];
        } else if (diff == 2) {
          dmedium[id] = pre.getInt('dmedium$id') ?? 0;
          this.data["currentLevel"] = dmedium[id];
          curLevel = dmedium[id];
        } else if (diff == 3) {
          dhard[id] = pre.getInt('dhard$id') ?? 0;
          this.data["currentLevel"] = dhard[id];
          curLevel = dhard[id];
        }
      }
    });
  }

  validate() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    if (!daily) {
      if (diff == 1) {
        if (ndeasy[id] < 0) {
          ndeasy[id] = (pre.getInt('easy$id') ?? 0);
          ndeasy[id] = 0;
          pre.setInt('easy$id', ndeasy[id]);
        } else if (ndeasy[id] > 51) {
          ndeasy[id] = (pre.getInt('easy$id') ?? 0);
          ndeasy[id] = 51;
          pre.setInt('easy$id', ndeasy[id]);
        }
      } else if (diff == 2) {
        if (ndmedium[id] < 0) {
          ndmedium[id] = (pre.getInt('medium$id') ?? 0);
          ndmedium[id] = 0;
          pre.setInt('medium$id', ndmedium[id]);
        }
        if (ndmedium[id] > 34) {
          ndmedium[id] = (pre.getInt('medium$id') ?? 0);
          ndmedium[id] = 34;
          pre.setInt('medium$id', ndmedium[id]);
        }
      } else if (diff == 3) {
        if (ndhard[id] < 0) {
          ndhard[id] = (pre.getInt('hard$id') ?? 0);
          ndhard[id] = 0;
          pre.setInt('hard$id', ndhard[id]);
        }
        if (ndhard[id] > 17) {
          ndhard[id] = (pre.getInt('hard$id') ?? 0);
          ndhard[id] = 17;
          pre.setInt('hard$id', ndhard[id]);
        }
      }
    } else if (daily && quiz == 1) {
      // else if (daily) {
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
  }

  updateCounter(int i, int points) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasy[i] = (pre.getInt('easy$i') ?? 0) + points;
          validate();

          // Navigator.of(context).push(
          //     new MaterialPageRoute(
          //         builder: (BuildContext context){
          //           return new HomeScreen();
          //         }
          //     )
          // );

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('easy$i', ndeasy[i]);
          curLevel = ndeasy[id];
          if (points == 1 &&
              ndeasy[i] ~/ 3 > (ndeasy[i] - 1) ~/ 3 &&
              ndeasy[i] <= 51) {
            levelChange = 1;
          } else if (points == -1 &&
              ndeasy[i] ~/ 3 < (ndeasy[i] + 1) ~/ 3 &&
              ndeasy[i] >= 0) {
            levelChange = -1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 2) {
          ndmedium[i] = (pre.getInt('medium$i') ?? 0) + points;
          validate();

          // Navigator.of(context).push(
          //     new MaterialPageRoute(
          //         builder: (BuildContext context){
          //           return new HomeScreen();
          //         }
          //     )
          // );

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('medium$i', ndmedium[i]);
          curLevel = ndmedium[id];
          if (points == 1 &&
              (ndmedium[i] ~/ 2 > (ndmedium[i] - 1) ~/ 2) &&
              ndmedium[i] <= 34) {
            levelChange = 1;
          } else if (points == -1 &&
              (ndmedium[i] ~/ 2 < (ndmedium[i] + 1) ~/ 2) &&
              ndmedium[i] >= 0) {
            levelChange = -1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 3) {
          ndhard[i] = (pre.getInt('hard$i') ?? 0) + points;
          // this.data["currentLevel"]=ndhard[i];
          validate();

          // Navigator.of(context).push(
          //     new MaterialPageRoute(
          //         builder: (BuildContext context){
          //           return new HomeScreen();
          //         }
          //     )
          // );

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('hard$i', ndhard[i]);
          curLevel = ndhard[id];
          if (points == 1 && ndhard[i] <= 17) {
            levelChange = 1;
          } else if (points == -1 && ndhard[i] >= 0) {
            levelChange = -1;
          } else {
            levelChange = 0;
          }
        }
      } else if (daily && quiz == 1) {
        // else if (daily) {
        if (diff == 1) {
          deasy[i] = (pre.getInt('deasy$i') ?? 0) + points;
          validate();

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('deasy$i', deasy[i]);
          curLevel = deasy[id];
          if (points == 1 &&
              getLevel(1, deasy[i], daily) >
                  (getLevel(1, deasy[i] - 1, daily)) &&
              deasy[i] <= 377) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 2) {
          dmedium[i] = (pre.getInt('dmedium$i') ?? 0) + points;
          validate();

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('dmedium$i', dmedium[i]);
          curLevel = dmedium[id];
          if (points == 1 &&
              getLevel(2, dmedium[i], daily) >
                  (getLevel(2, dmedium[i] - 1, daily)) &&
              dmedium[i] <= 257) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        } else if (diff == 3) {
          dhard[i] = (pre.getInt('dhard$i') ?? 0) + points;
          validate();

          // Flashcard f = new Flashcard(flashcardModel,index);
          // f.loadCounter(diff,id);
          // this.data["currentLevel"]=ndeasy[i];

          pre.setInt('dhard$i', dhard[i]);
          curLevel = dhard[id];
          if (points == 1 &&
              getLevel(3, dhard[i], daily) >
                  (getLevel(3, dhard[i] - 1, daily)) &&
              dhard[i] <= 137) {
            levelChange = 1;
          } else {
            levelChange = 0;
          }
        }
        validate();
      }
    });
  }

  resetCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    for (int i = 0; i < 9; i++) {
      pre.setInt('easy$i', 0);
    }
    for (int i = 0; i < 19; i++) {
      pre.setInt('medium$i', 0);
    }
    for (int i = 0; i < 12; i++) {
      pre.setInt('hard$i', 0);
    }
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
                    int a = 0;
                    if (numOfOptions == 2) {
                      if (e == (data["options"] as List)[0] && level) {
                        await updateCounter(id, 1);
                        a = 1;
                      } else if (e == (data["options"] as List)[1] &&
                          level &&
                          !daily) {
                        await updateCounter(id, -1);
                        a = 1;
                      } else if (e == (data["options"] as List)[1] &&
                          level &&
                          daily) {
                        this.levelChange = 0;
                      }
                    } else if (numOfOptions == 3) {
                      if (e == (data["options"] as List)[0] && level) {
                        await updateCounter(id, 1);
                        a = 1;
                      } else if (e == (data["options"] as List)[1] &&
                          level &&
                          !daily) {
                        await updateCounter(id, -1);
                        a = 1;
                      } else if (e == (data["options"] as List)[2] &&
                          level &&
                          daily) {
                        this.levelChange = 0;
                      }
                    }

                    if (this.levelChange == -1) {
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
                                          '${badges[getLevel(diff, curLevel, daily)]}',
                                          height: 140,
                                          width: 140,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Center(
                                        child: Text(
                                          'Unfortunately,',
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
                                          'you’re levelling down',
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
                                          'Seems like you have lost your consistency...but do not get demotivated! There’s a saying, “Old habits die hard” . It’s alright, you can always start afresh, and remember, CONSISTENCY is the key!',
                                          style: TextStyle(
                                            fontSize: 18.0,
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
                                          'LEVEL ${getLevel(diff, curLevel, daily)}',
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
                                ));
                          });
                    } else if (this.levelChange == 1) {
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
                                        '${badges[getLevel(diff, curLevel, daily)]}',
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
                                        'LEVEL ${getLevel(diff, curLevel, daily)}',
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

                      // if(a==1){
                      //   return DailyQuiz(index+1);
                      // }
                    }

                    // Navigator.pop(context);
                    // if(levelChange!=0) {
                    //   Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => HomeScreen(),
                    //   ));
                    // }
                    // else{
                    //   Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => Details(this.flashcardModel,index),
                    //   ));
                    // }
                  },
                  child: Text(
                    e,
                    style: TextStyle(color: const Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
            Text(
                '${getLevel(diff, curLevel, daily)},$diff,$id,$daily,$index,$rem,$level'),
          ],
        ),
      ),
    );
  }
}
