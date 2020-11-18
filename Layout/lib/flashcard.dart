// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'details.dart';
//
// class Flashcard extends StatefulWidget {
//   final Map flashcard;
//   Flashcard(this.flashcard);
//   @override
//   _FlashcardState createState() => _FlashcardState();
// }
//
// class _FlashcardState extends State<Flashcard> {
//   // final double unexpandedBadgeSize = 50;
//   // final double expandedBadgeSize = 100;
//   // double badgeSize;
//
//   void showDetailsScreen(BuildContext context) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return Details(widget.flashcard);
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: 5,
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 5,
//         vertical: 5,
//       ),
//       child: InkWell(
//         onDoubleTap: () => showDetailsScreen(context),
//         child: ExpansionTileCard(
//           trailing: SvgPicture.asset(
//             (widget.flashcard["badge"] as Map)["path"]
//             [(widget.flashcard["currentLevel"] as int) - 1],
//           ),
//
//           /*
//           to change the size of the badge upon expansion
//           onExpansionChanged: (value) {
//             setState(() {
//               value
//                   ? badgeSize = expandedBadgeSize
//                   : badgeSize = unexpandedBadgeSize;
//             });
//           },
//           */
//
//           baseColor: Color(
//             widget.flashcard["color"],
//           ),
//           expandedColor: Color(
//             widget.flashcard["color"],
//           ),
//           title: Row(
//             children: [
//               Text(
//                 widget.flashcard["title"],
//                 style: TextStyle(
//                   color: const Color(
//                     0xffFFFFFF,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Text(
//                 widget.flashcard["shortDescription"],
//                 style: TextStyle(
//                   color: const Color(
//                     0xffFFFFFF,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:Layout/models/details.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'details.dart';
import 'flashcard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class Flashcard extends StatefulWidget {
  final FlashcardModel flashcardModel;
  final int index;
  Flashcard(this.flashcardModel, this.index);

  loadCounter(int diff, int id) {
    _FlashcardState f = new _FlashcardState(this.index);
    f.loadCounter1(diff, id);
  }

  @override
  _FlashcardState createState() => _FlashcardState(this.index);
}

class _FlashcardState extends State<Flashcard> {
  // final double unexpandedBadgeSize = 50;
  // final double expandedBadgeSize = 100;
  // double badgeSize;

  void showDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Details(widget.flashcardModel, index);
    }));
  }

  int index;
  int id;
  int diff;
  bool daily, level;
  int quiz;
  List<String> badges;
  // Map<String, Object> data;
  int curLevel = 0;

  _FlashcardState(this.index);

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

  @override
  void initState() {
    super.initState();
    // id = widget.flashcardModel.id;
    // id -= 1;
    // diff = widget.flashcardModel.difficulty["scale"];
    // daily = widget.flashcardModel.isDaily;
    // level = widget.flashcardModel.hasLevel;
    // badges = widget.flashcardModel.badge["path"];
    id = data[index]["id"];
    id -= 1;
    diff = (data[index]["difficulty"] as Map)["scale"];
    daily = data[index]["isDaily"];
    level = data[index]["hasLevel"];
    badges = ((data[index]["badge"] as Map)["path"] as List);
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
    } else if (daily && quiz == 1) {
      // else if (daily) {
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
    loadCounter1(diff, id);
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
    return -1; // added to remove warnings
  }

  loadCounter1(diff, id) async {
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
    // build(context);
    //   HomeScreen h=new HomeScreen();
    //       h.run();
  }

  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: InkWell(
        onDoubleTap: () => showDetailsScreen(context),
        child: ExpansionTileCard(
          trailing: widget.flashcardModel.hasLevel
              ? SizedBox(
                  height: 80,
                  width: 80,
                  child: SvgPicture.asset(
                    // need to change this later
                    widget.flashcardModel.badge["path"]
                        [widget.flashcardModel.currentLevel - 1],
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          /*
          to change the size of the badge upon expansion
          onExpansionChanged: (value) {
            setState(() {
              value
                  ? badgeSize = expandedBadgeSize
                  : badgeSize = unexpandedBadgeSize;
            });
          },
          */

          baseColor: widget.flashcardModel.color,
          expandedColor: widget.flashcardModel.color,
          title: Row(
            children: [
              Text(
                widget.flashcardModel.title,
                style: TextStyle(
                  color: const Color(
                    0xffFFFFFF,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.flashcardModel.shortDescription,
                style: TextStyle(
                  color: const Color(
                    0xffFFFFFF,
                  ),
                ),
              ),
            ),
            Text(
              '${getLevel(diff, curLevel, daily)},$diff,$id,$daily,$curLevel,$index',
            ),
          ],
        ),
      ),
    );
  }
}
