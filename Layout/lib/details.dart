import 'dart:math';

import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'badgeDetails.dart';
import 'data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homescreen.dart';

class Details extends StatefulWidget {
  final FlashcardModel flashcardModel;
  Details(this.flashcardModel, this.index);
  int index;

  @override
  _DetailsState createState() => _DetailsState(this.flashcardModel, this.index);
}

class _DetailsState extends State<Details> {
  void showBadgeDetails(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BadgeDetailsScreen();
    }));
  }

  int index;
  FlashcardModel flashcardModel;

  _DetailsState(this.flashcardModel, this.index);

  Color iconColor;

  // List<bool> ndeasyrem = new List(9);
  // List<String> easystringrem = new List(9);
  // List<bool> ndmediumrem = new List(19);
  // List<String> mediumstringrem = new List(19);
  // List<bool> ndhardrem = new List(12);
  // List<String> hardstringrem = new List(12);
  //
  // List<bool> deasyrem = new List(2);
  // List<String> deasystringrem = new List(2);
  // List<bool> dmediumrem = new List(6);
  // List<String> dmediumstringrem = new List(6);
  // List<bool> dhardrem = new List(3);
  // List<String> dhardstringrem = new List(3);

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

  int diff, id;
  bool daily, level;
  List<String> badges;

  @override
  void initState() {
    super.initState();
    id = data[index]["id"];
    id -= 1;
    diff = (data[index]["difficulty"] as Map)["scale"];
    daily = data[index]["isDaily"];
    if((data[index]["badge"] as Map)!=null) {
      badges = ((data[index]["badge"] as Map)["path"] as List);
    }
    else{
      badges=[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null];
    }
    // level = data[0]["hasLevel"];
    // if (!daily) {
    //   if (diff == 1) {
    //     ndeasyrem[id] = false;
    //     easystringrem[id] = "easyrem$id";
    //   } else if (diff == 2) {
    //     ndmediumrem[id] = false;
    //     mediumstringrem[id] = "mediumrem$id";
    //   } else if (diff == 3) {
    //     ndhardrem[id] = false;
    //     hardstringrem[id] = "hardrem$id";
    //   }
    // }
    // // } else if (daily && quiz == 1) {
    // else if (daily) {
    //   if (diff == 1) {
    //     deasyrem[id] = false;
    //     deasystringrem[id] = "deasyrem$id";
    //   } else if (diff == 2) {
    //     dmediumrem[id] = false;
    //     dmediumstringrem[id] = "dmediumrem$id";
    //   } else if (diff == 3) {
    //     dhardrem[id] = false;
    //     dhardstringrem[id] = "dhardrem$id";
    //   }
    // }
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
    for(int i=0;i<9;i++){
      ndeasy[i]=0;
    }
    for(int i=0;i<19;i++){
      ndmedium[i]=0;
    }
    for(int i=0;i<12;i++){
      ndhard[i]=0;
    }
    for(int i=0;i<2;i++){
      deasy[i]=0;
    }
    for(int i=0;i<6;i++){
      dmedium[i]=0;
    }
    for(int i=0;i<3;i++){
      dhard[i]=0;
    }
    loadCounter(diff, id);
    loadCounter2();
  }

  // loadCounter(diff, id) async {
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   setState(() {
  //     if (!daily) {
  //       if (diff == 1) {
  //         ndeasyrem[id] = pre.getBool('easyrem$id') ?? false;
  //         // data[index]["currentLevel"]=ndeasy[id];
  //         r = ndeasyrem[id];
  //         if (ndeasyrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       } else if (diff == 2) {
  //         ndmediumrem[id] = pre.getBool('mediumrem$id') ?? false;
  //         // data[index]["currentLevel"]=ndmedium[id];
  //         r = ndmediumrem[id];
  //         if (ndmediumrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       } else if (diff == 3) {
  //         ndhardrem[id] = pre.getBool('hardrem$id') ?? false;
  //         // data[index]["currentLevel"]=ndhard[id];
  //         r = ndhardrem[id];
  //         if (ndhardrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       }
  //     }
  //     // } else if (daily && quiz == 1) {
  //     else if (daily) {
  //       if (diff == 1) {
  //         deasyrem[id] = pre.getBool('deasyrem$id') ?? false;
  //         // data[index]["currentLevel"]=deasy[id];
  //         r = deasyrem[id];
  //         if (deasyrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       } else if (diff == 2) {
  //         dmediumrem[id] = pre.getBool('dmediumrem$id') ?? false;
  //         r = dmediumrem[id];
  //         // data[index]["currentLevel"]=dmedium[id];
  //         if (dmediumrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       } else if (diff == 3) {
  //         dhardrem[id] = pre.getBool('dhardrem$id') ?? false;
  //         r = dhardrem[id];
  //         // data[index]["currentLevel"]=dhard[id];
  //         if (dhardrem[id] == false) {
  //           iconColor = Colors.pink;
  //         } else {
  //           iconColor = Colors.yellow;
  //         }
  //       }
  //     }
  //   });
  // }

  // bool r;

  int curLevel;

  loadCounter(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasy[id] = pre.getInt('easy$id') ?? 0;
          data[index]["currentLevel"] = ndeasy[id];
          curLevel = ndeasy[id];
        } else if (diff == 2) {
          ndmedium[id] = pre.getInt('medium$id') ?? 0;
          data[index]["currentLevel"] = ndmedium[id];
          curLevel = ndmedium[id];
        } else if (diff == 3) {
          ndhard[id] = pre.getInt('hard$id') ?? 0;
          data[index]["currentLevel"] = ndhard[id];
          curLevel = ndhard[id];
        }
      }
      // } else if (daily && quiz == 1) {
        else if (daily) {
        if (diff == 1) {
          deasy[id] = pre.getInt('deasy$id') ?? 0;
          data[index]["currentLevel"] = deasy[id];
          curLevel = deasy[id];
        } else if (diff == 2) {
          dmedium[id] = pre.getInt('dmedium$id') ?? 0;
          data[index]["currentLevel"] = dmedium[id];
          curLevel = dmedium[id];
        } else if (diff == 3) {
          dhard[id] = pre.getInt('dhard$id') ?? 0;
          data[index]["currentLevel"] = dhard[id];
          curLevel = dhard[id];
        }
      }
    });
  }

  // updateCounter() async {
  //   SharedPreferences pre = await SharedPreferences.getInstance();
  //   setState(() {
  //     if (!daily) {
  //       if (diff == 1) {
  //         ndeasyrem[id] = pre.getBool('easyrem$id') ?? false;
  //         if (ndeasyrem[id] == false) {
  //           pre.setBool('easyrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('easyrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       } else if (diff == 2) {
  //         ndmediumrem[id] = pre.getBool('mediumrem$id') ?? false;
  //         if (ndmediumrem[id] == false) {
  //           pre.setBool('mediumrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('mediumrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       } else if (diff == 3) {
  //         ndhardrem[id] = pre.getBool('hardrem$id') ?? false;
  //         if (ndhardrem[id] == false) {
  //           pre.setBool('hardrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('hardrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       }
  //     } else if (daily) {
  //       if (diff == 1) {
  //         deasyrem[id] = pre.getBool('deasyrem$id') ?? false;
  //         if (deasyrem[id] == false) {
  //           pre.setBool('deasyrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('deasyrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       } else if (diff == 2) {
  //         dmediumrem[id] = pre.getBool('dmediumrem$id') ?? false;
  //         if (dmediumrem[id] == false) {
  //           pre.setBool('dmediumrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('dmediumrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       } else if (diff == 3) {
  //         dhardrem[id] = pre.getBool('dhardrem$id') ?? false;
  //         if (dhardrem[id] == false) {
  //           pre.setBool('dhardrem$id', true);
  //           iconColor = Colors.yellow;
  //         } else {
  //           pre.setBool('dhardrem$id', false);
  //           iconColor = Colors.pink;
  //         }
  //       }
  //     }
  //   });
  // }

  int getl(int diff,int id, bool daily) {
    int an;
    if(!daily){
      if(diff==1){
        an= ndeasy[id];
      }
      else if(diff==2){
        an= ndmedium[id];
      }
      else if(diff==3){
        an= ndhard[id];
      }
    }
    else{
      if(diff==1){
        an= deasy[id];
      }
      else if(diff==2){
        an= dmedium[id];
      }
      else if(diff==3){
        an= dhard[id];
      }
    }
    return getLevel(diff, an, daily);
  }

  loadCounter2() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      for(int i=0;i<9;i++){
        ndeasy[i]=pre.getInt('easy$i') ?? 0;
      }
      for(int i=0;i<19;i++){
        ndmedium[i]=pre.getInt('medium$i') ?? 0;
      }
      for(int i=0;i<12;i++){
        ndhard[i]=pre.getInt('hard$i') ?? 0;
      }
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
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => HomeScreen(),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          widget.flashcardModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: const Color(
                              0xffFFFFFF,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.flashcardModel.difficulty["text"],
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color(
                              0xffFFFFFF,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Flexible(
                    child: Container(
                      child: GestureDetector(
                        onTap: () => showBadgeDetails(context),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: widget.flashcardModel.badge!=null ? SvgPicture.asset(
                            widget.flashcardModel.badge["path"][getl(widget.flashcardModel.difficulty["scale"], widget.flashcardModel.id-1, widget.flashcardModel.isDaily)],
                            )
                              :SizedBox(height: 0,width: 0,),
                                  ),
                          ),
                        ),
                      ),
                    ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            ...widget.flashcardModel.longDescription.map((text) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: widget.flashcardModel.color,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 25,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: const Color(
                          0xffFFFFFF,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            if (flashcardModel.hasLinks)
              ...(flashcardModel.visualization["links"] as List)
                  .map(
                    (link) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: flashcardModel.color,
                        onPressed: () => _launchURL(link["link"]),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            link["text"],
                            style: TextStyle(color: const Color(0xffFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            // Text(
            //   '$r',
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

_launchURL(String link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
