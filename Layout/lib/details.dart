// // import 'package:Layout/models/badgeDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'badgeDetails.dart';
//
// class Details extends StatelessWidget {
//   final Map flashcard;
//   Details(this.flashcard);
//   void showBadgeDetails(BuildContext context) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return BadgeDetailsScreen();
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(
//         0xff2C2E36,
//       ),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text("ECO"),
//         centerTitle: true,
//         backgroundColor: const Color(
//           0xff2C2E36,
//         ),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.account_circle,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 FittedBox(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                     child: Column(
//                       children: [
//                         Text(
//                           flashcard["title"],
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: const Color(
//                               0xffFFFFFF,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           (flashcard["difficulty"] as Map)["text"],
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: const Color(
//                               0xffFFFFFF,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     width: 5,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: Flexible(
//                     child: Container(
//                       child: GestureDetector(
//                         onTap: () => showBadgeDetails(context),
//                         child: SvgPicture.asset(
//                           (flashcard["badge"] as Map)["path"]
//                           [flashcard["currentLevel"] - 1],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//               ],
//             ),
//             ...(flashcard["longDescription"] as List).map((text) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 5,
//                   vertical: 2,
//                 ),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   color: Color(flashcard["color"]),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 25,
//                     ),
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                         color: const Color(
//                           0xffFFFFFF,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:Layout/models/badgeDetails.dart';
// import 'package:Layout/flashcard_model.dart';

import 'flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'badgeDetails.dart';
import 'data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<bool> ndeasyrem = new List(9);
  List<String> easystringrem = new List(9);
  List<bool> ndmediumrem = new List(19);
  List<String> mediumstringrem = new List(19);
  List<bool> ndhardrem = new List(12);
  List<String> hardstringrem = new List(12);

  List<bool> deasyrem = new List(2);
  List<String> deasystringrem = new List(2);
  List<bool> dmediumrem = new List(6);
  List<String> dmediumstringrem = new List(6);
  List<bool> dhardrem = new List(3);
  List<String> dhardstringrem = new List(3);

  int diff, id;
  bool daily, level;

  @override
  void initState() {
    super.initState();
    id = data[index]["id"];
    id -= 1;
    diff = (data[index]["difficulty"] as Map)["scale"];
    daily = data[index]["isDaily"];
    // level = data[0]["hasLevel"];
    if (!daily) {
      if (diff == 1) {
        ndeasyrem[id] = false;
        easystringrem[id] = "easyrem$id";
      } else if (diff == 2) {
        ndmediumrem[id] = false;
        mediumstringrem[id] = "mediumrem$id";
      } else if (diff == 3) {
        ndhardrem[id] = false;
        hardstringrem[id] = "hardrem$id";
      }
    }
    // } else if (daily && quiz == 1) {
    else if (daily) {
      if (diff == 1) {
        deasyrem[id] = false;
        deasystringrem[id] = "deasyrem$id";
      } else if (diff == 2) {
        dmediumrem[id] = false;
        dmediumstringrem[id] = "dmediumrem$id";
      } else if (diff == 3) {
        dhardrem[id] = false;
        dhardstringrem[id] = "dhardrem$id";
      }
    }
    loadCounter(diff, id);
  }

  loadCounter(diff, id) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasyrem[id] = pre.getBool('easyrem$id') ?? false;
          // this.data["currentLevel"]=ndeasy[id];
          r = ndeasyrem[id];
          if (ndeasyrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        } else if (diff == 2) {
          ndmediumrem[id] = pre.getBool('mediumrem$id') ?? false;
          // this.data["currentLevel"]=ndmedium[id];
          r = ndmediumrem[id];
          if (ndmediumrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        } else if (diff == 3) {
          ndhardrem[id] = pre.getBool('hardrem$id') ?? false;
          // this.data["currentLevel"]=ndhard[id];
          r = ndhardrem[id];
          if (ndhardrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        }
      }
      // } else if (daily && quiz == 1) {
      else if (daily) {
        if (diff == 1) {
          deasyrem[id] = pre.getBool('deasyrem$id') ?? false;
          // this.data["currentLevel"]=deasy[id];
          r = deasyrem[id];
          if (deasyrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        } else if (diff == 2) {
          dmediumrem[id] = pre.getBool('dmediumrem$id') ?? false;
          r = dmediumrem[id];
          // this.data["currentLevel"]=dmedium[id];
          if (dmediumrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        } else if (diff == 3) {
          dhardrem[id] = pre.getBool('dhardrem$id') ?? false;
          r = dhardrem[id];
          // this.data["currentLevel"]=dhard[id];
          if (dhardrem[id] == false) {
            iconColor = Colors.pink;
          } else {
            iconColor = Colors.yellow;
          }
        }
      }
    });
  }

  bool r;

  updateCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      if (!daily) {
        if (diff == 1) {
          ndeasyrem[id] = pre.getBool('easyrem$id') ?? false;
          if (ndeasyrem[id] == false) {
            pre.setBool('easyrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('easyrem$id', false);
            iconColor = Colors.pink;
          }
        } else if (diff == 2) {
          ndmediumrem[id] = pre.getBool('mediumrem$id') ?? false;
          if (ndmediumrem[id] == false) {
            pre.setBool('mediumrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('mediumrem$id', false);
            iconColor = Colors.pink;
          }
        } else if (diff == 3) {
          ndhardrem[id] = pre.getBool('hardrem$id') ?? false;
          if (ndhardrem[id] == false) {
            pre.setBool('hardrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('hardrem$id', false);
            iconColor = Colors.pink;
          }
        }
      } else if (daily) {
        if (diff == 1) {
          deasyrem[id] = pre.getBool('deasyrem$id') ?? false;
          if (deasyrem[id] == false) {
            pre.setBool('deasyrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('deasyrem$id', false);
            iconColor = Colors.pink;
          }
        } else if (diff == 2) {
          dmediumrem[id] = pre.getBool('dmediumrem$id') ?? false;
          if (dmediumrem[id] == false) {
            pre.setBool('dmediumrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('dmediumrem$id', false);
            iconColor = Colors.pink;
          }
        } else if (diff == 3) {
          dhardrem[id] = pre.getBool('dhardrem$id') ?? false;
          if (dhardrem[id] == false) {
            pre.setBool('dhardrem$id', true);
            iconColor = Colors.yellow;
          } else {
            pre.setBool('dhardrem$id', false);
            iconColor = Colors.pink;
          }
        }
      }
    });
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
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () async {
                    setState(() async {
                      // if (iconColor == Colors.pink) {
                      //   // iconColor = Colors.yellow;
                      //   await updateCounter();
                      //   widget.flashcardModel.hasReminder = true;
                      // } else {
                      //   // iconColor = Colors.pink;
                      //   await updateCounter();
                      //   widget.flashcardModel.hasLevel = false;
                      // }

                      await updateCounter();
                    });
                  },
                  color: iconColor,
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
                        child: FittedBox(
                          child: SvgPicture.asset(
                            (widget.flashcardModel.badge)["path"]
                                [widget.flashcardModel.currentLevel - 1],
                          ),
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
            Text(
              '$r',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
