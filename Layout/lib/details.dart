// import 'package:Layout/models/badgeDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'badgeDetails.dart';

class Details extends StatelessWidget {
  final Map flashcard;
  Details(this.flashcard);
  void showBadgeDetails(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BadgeDetailsScreen();
    }));
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
          onPressed: () => Navigator.of(context).pop(),
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
              Icons.account_circle_outlined,
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
                          flashcard["title"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: const Color(
                              0xffFFFFFF,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          (flashcard["difficulty"] as Map)["text"],
                          style: TextStyle(
                            fontSize: 20,
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
                        child: SvgPicture.asset(
                          (flashcard["badge"] as Map)["path"]
                              [flashcard["currentLevel"] - 1],
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
            ...(flashcard["longDescription"] as List).map((text) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(flashcard["color"]),
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
          ],
        ),
      ),
    );
  }
}
