import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp/breathe_in.dart';
import 'package:temp/ecommunity_info.dart';
import 'package:temp/question_of_the_day.dart';
import 'package:temp/smart_plug.dart';
import 'dailyQuiz.dart';
import 'data.dart';
import 'environmentalDays_model.dart';
import 'flashcard.dart';
import 'flashcard_model.dart';
import 'flashcardsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int randomIndex;
  bool hasAnswered = false;
  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _answer(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FlashcardsScreen(randomIndex);
    }));
    setState(() {
      hasAnswered = true;
    });
  }

  _setLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastOpenedTime", DateTime.now().toIso8601String());
  }

  _getLastOpenedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpenedTimeString =
        prefs.getString("lastOpenedTime") ?? DateTime(2000).toIso8601String();
    return DateTime.parse(lastOpenedTimeString);
  }

  _generateRandomNumber() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime lastOpenedTime = await _getLastOpenedTime();
    print("$lastOpenedTime 2");
    print("$randomIndex");
    if (lastOpenedTime
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      int randomIndex = Random().nextInt(10);
      String lastCardShownDateString =
          prefs.getString("lastShown" + randomIndex.toString()) ?? "";
      DateTime lastCardShownDate;
      if (lastCardShownDateString == "") {
        prefs.setString("lastShown" + randomIndex.toString(),
            DateTime.now().toIso8601String());
        lastCardShownDate = DateTime.parse(
            prefs.getString("lastShown" + randomIndex.toString()));
      } else {
        lastCardShownDate = DateTime.parse(lastCardShownDateString);
      }
      while (!lastCardShownDate.isBefore(DateTime.now()
          .subtract(Duration(days: flashcardModels[randomIndex].frequency)))) {
        randomIndex = Random().nextInt(flashcardModels.length);
        lastCardShownDate = DateTime.parse(
            prefs.getString("lastShown" + randomIndex.toString()) ??
                DateTime(2000).toIso8601String());
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
    } else {
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
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DailyQuiz(0);
    }));
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
    if (!hasAnswered) {
      return QuestionOfTheDay(flashcardModels[randomIndex].question,
          flashcardModels[randomIndex].options, () => _answer(context));
    }
    // if (timeAnswered
    //     .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
    //   return QuestionOfTheDay(flashcardModels[randomIndex].question,
    //       flashcardModels[randomIndex].options, _setTimeAnswered);
    // }
    return Flashcard(flashcardModels[randomIndex], randomIndex);
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
                      InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return SmartPlug();
                        })),
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return BreatheIn();
                        })),
                        child: Container(
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
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return Ecommunity();
                        })),
                        child: Container(
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
