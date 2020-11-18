import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dailyQuiz.dart';
import 'data.dart';
import 'environmentalDays_model.dart';
import 'flashcard.dart';
import 'flashcard_model.dart';
import 'question.dart';
import 'flashcardsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int randomIndex;
  DateTime dans;
  DateTime dq;
  int show;
  int qshow;

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
    // resetAnswer();
    validateAnswer();
    // resetAnswer();
  }

  void resetAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('time_answered', null);
    prefs.setString('takeq', null);
  }

  // void validateAnswer() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String getdans = prefs.getString('time_answered') ?? null;
  //   String getquiz = prefs.getString('takeq') ?? null;
  //   // if (getdans == null) {
  //   //   setState(() {
  //   //     show=0;
  //   //   });
  //   //   show = 0;
  //   // }
  //   // else {
  //   //   dans = DateTime.parse(getdans);
  //   //   // DateTime lastOpenedTime = await _getLastOpenedTime();
  //   //   // randomIndex=_generateRandomNumber();
  //   //   print('ranodmidex: ${this.randomIndex}');
  //   //   String lastCardShownDateString = prefs.getString("lastShown" + randomIndex.toString()) ?? null;
  //   //   // print('last opened: $lastOpenedTime');
  //   //   DateTime lastOpenedTime = DateTime.parse(lastCardShownDateString);
  //   //   if (!lastOpenedTime.isBefore(dans.subtract(const Duration(days: 1))) && !lastOpenedTime.isAfter(dans)) {
  //   //     setState(() {
  //   //       show=1;
  //   //     });
  //   //     show = 1;
  //   //   }
  //   //   else {
  //   //     prefs.setString('time_answered', null);
  //   //     setState(() {
  //   //       show=0;
  //   //     });
  //   //     show = 0;
  //   //   }
  //   // }
  //   // print('Show: $show');
  //   // print('$getdans');
  //   // // print('${dans.subtract(const Duration(days: 1))}');
  //
  //   if (getquiz == null) {
  //     setState(() {
  //       qshow = 0;
  //     });
  //     qshow = 0;
  //   }
  //   else {
  //     dq = DateTime.parse(getquiz);
  //     // DateTime lastOpenedTime = await _getLastOpenedTime();
  //     int r = prefs.getInt('randomIndex') ?? 0;
  //     print('randomIndex: $r');
  //     // DateTime lastCardTime = DateTime.parse(prefs.getString("lastShown$r"));
  //     DateTime lastCardTime = DateTime.parse(null);
  //     print('last card: $lastCardTime');
  //     if (!lastCardTime.isBefore(dq.subtract(const Duration(days: 1))) &&
  //         !lastCardTime.isAfter(dq)) {
  //       setState(() {
  //         qshow = 1;
  //       });
  //       qshow = 1;
  //     }
  //     else {
  //       prefs.setString('takeq', null);
  //       setState(() {
  //         qshow = 0;
  //       });
  //       qshow = 0;
  //     }
  //   }
  //   print('getquiz: $getquiz');
  //   print('qshow: $qshow');
  //   int r = prefs.getInt('randomIndex') ?? 0;
  //   print('randomIndex: $r');
  //   DateTime lastCardTime = DateTime.parse(prefs.getString("lastShown$r"));
  //   print('last card: $lastCardTime');
  // }

  validateAnswer() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      String lastTaken = pre.getString('takeq') ?? "";
      if(lastTaken==""){
        pre.setString('takeq', DateTime.now().toIso8601String());
      }
      else{
        int d=pre.getInt('diff') ?? -1;
        if(d==-1){
          qshow=0;
        }
        else{
          int dif;
          dif=DateTime.now().difference(DateTime.parse(pre.getString('takeq') ?? DateTime(2000).toIso8601String())).inSeconds;
          pre.setInt('diff',dif);
          print('d: $dif');
          if(dif>=30){
            qshow=0;
          }
          else{
            qshow=1;
          }
        }
      }
      print('date time: $lastTaken');
      // qshow=0;
    });
  }

  _setLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastOpenedTime", DateTime.now().toIso8601String());
  }

  _getLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpenedTimeString = prefs.getString("lastOpenedTime") ?? DateTime(2000).toIso8601String();
    return DateTime.parse(lastOpenedTimeString);
  }

  // _generateRandomNumber() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   DateTime lastOpenedTime = await _getLastOpenedTime();
  //   print("$lastOpenedTime 2");
  //   print("$randomIndex");
  //   // int r=prefs.getInt('randomIndex') ?? 0;
  //   // prefs.setString('lastShown$r', DateTime(2000).toIso8601String());
  //   // DateTime lastCardTime = DateTime.parse(prefs.getString("lastShown$r"));
  //   if (lastOpenedTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
  //     int randomIndex = Random().nextInt(10);
  //     print('$randomIndex');
  //     String lastCardShownDateString = prefs.getString("lastShown$randomIndex") ?? "";
  //     DateTime lastCardShownDate;
  //     if (lastCardShownDateString == "") {
  //       // print('a');
  //       prefs.setString("lastShown$randomIndex", DateTime.now().toIso8601String());
  //       lastCardShownDate = DateTime.parse(prefs.getString("lastShown$randomIndex"));
  //     } else {
  //       lastCardShownDate = DateTime.parse(lastCardShownDateString);
  //     }
  //     while (!lastCardShownDate.isBefore(DateTime.now().subtract(Duration(days: flashcardModels[randomIndex].frequency)))) {
  //       randomIndex = Random().nextInt(flashcardModels.length);
  //       lastCardShownDate = DateTime.parse(prefs.getString("lastShown$randomIndex") ?? DateTime(2000).toIso8601String());
  //     }
  //     int temp = prefs.getInt("randomIndex") ?? 0;
  //     await prefs.setInt("randomIndex", randomIndex);
  //     temp = randomIndex;
  //     if (temp != null) {
  //       setState(() {
  //         this.randomIndex = temp;
  //       });
  //     }
  //     print("random index generated successfully!");
  //   }
  //   else {
  //     int temp = prefs.getInt("randomIndex") ?? 0;
  //     print(temp);
  //     if (temp != null) {
  //       setState(() {
  //         this.randomIndex = temp;
  //       });
  //     }
  //   }
  //   await _setLastOpenedTime();
  //   int temp = prefs.getInt("randomIndex") ?? 0;
  //   print("${prefs.getString("lastOpenedTime")} 1");
  //   print("${prefs.getString("lastShown$temp")} 1 2");
  // }

  _generateRandomNumber() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime lastOpenedTime = await _getLastOpenedTime();
    print("$lastOpenedTime 2");
    print("$randomIndex");
    if (lastOpenedTime.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      int randomIndex = Random().nextInt(10);
      String lastCardShownDateString = prefs.getString("lastShown" + randomIndex.toString()) ?? "";
      DateTime lastCardShownDate;
      if (lastCardShownDateString == "") {
        prefs.setString("lastShown" + randomIndex.toString(), DateTime.now().toIso8601String());
        lastCardShownDate = DateTime.parse(prefs.getString("lastShown" + randomIndex.toString()));
      }
      else {
        lastCardShownDate = DateTime.parse(lastCardShownDateString);
      }
      while (!lastCardShownDate.isBefore(DateTime.now().subtract(Duration(days: flashcardModels[randomIndex].frequency)))) {
        randomIndex = Random().nextInt(flashcardModels.length);
        lastCardShownDate = DateTime.parse(prefs.getString("lastShown" + randomIndex.toString()) ?? DateTime(2000).toIso8601String());
      }
      int temp = prefs.getInt("randomIndex") ?? 0;
      await prefs.setInt("randomIndex", randomIndex);
      temp = randomIndex;
      if (temp != null) {
        setState(() {
          this.randomIndex = temp;
        });
      }
      print("random index generated successfully!");
    }
    else {
      int temp = prefs.getInt("randomIndex") ?? 0;
      print(temp);
      if (temp != null) {
        setState(() {
          this.randomIndex = temp;
        });
      }
    }
    await _setLastOpenedTime();
    print("${prefs.getString("lastOpenedTime")} 1");
  }

  void takeDailyQuiz(BuildContext context) {
    if (qshow == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DailyQuiz(0);
      }));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200.0,
              color: Color(0xffe5e5e5),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          'You have already taken the quiz for today! Please wait until tomorrow',
                          textAlign: TextAlign.center,
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
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  void showFlashcards(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FlashcardsScreen(randomIndex);
    }));
  }

  Widget flashcardOfTheDay() {
    DateTime today = DateTime.now();
    for (var environmentalDay in environmentalDays) {
      if ((environmentalDay["date"] as Map)["month"] == today.month) {
        if ((environmentalDay["date"] as Map)["day"] == today.day) {
          return EnvironmentalDayCard(environmentalDay);
        }
      }
    }
    if (show == 1) {
      return Flashcard(flashcardModels[randomIndex], randomIndex);
    }
    int r = randomIndex;
    // r=20;                                                                 // caution caution caution caution caution caution caution
    return Question(data[r]["question"], data[r]["options"], data[r], 0,
        flashcardModels[r], r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xff2C2E36,
      ),
      appBar: AppBar(
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
            onPressed: () => showFlashcards(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () => showFlashcards(context),
              child: flashcardOfTheDay(),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 25,
              height: 80,
              margin: EdgeInsets.all(5),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                color: const Color(0xffD91B5F),
                onPressed: () => takeDailyQuiz(context),
                child: Text(
                  "Take your daily quiz!",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
            // Card(
            //   child: SizedBox(
            //     child: ListView.builder(
            //       itemBuilder: (context, index) {
            //         return SizedBox(
            //           height: 80,
            //           width: 80,
            //           child: SvgPicture.asset("assets/Bulkasaur final.svg"),
            //         );
            //       },
            //       itemCount: 4,
            //     ),
            //   ),
            // ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.height * 0.29,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          color: const Color(0xffEA8134),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                "assets/Group 28.svg",
                              ),
                              Text(
                                "WASTE GURU",
                                style: TextStyle(
                                  color: const Color(0xffFFFFFF),
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.height * 0.29,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          color: const Color(0xffFF7262),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                "assets/Group 29.svg",
                              ),
                              Text(
                                "SMART PLUG",
                                style: TextStyle(
                                  color: const Color(0xffFFFFFF),
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.height * 0.29,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          color: const Color(0xffFF4F6A),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                "assets/Group 30.svg",
                              ),
                              Text(
                                "BREATHE IN",
                                style: TextStyle(
                                  color: const Color(0xffFFFFFF),
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        width: MediaQuery.of(context).size.height * 0.29,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          color: const Color(0xffFDB714),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                "assets/Group 31.svg",
                              ),
                              Text(
                                "ECOmmunity",
                                style: TextStyle(
                                  color: const Color(0xffFFFFFF),
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
