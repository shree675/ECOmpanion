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
        title: Text("ECO"),
        centerTitle: true,
        backgroundColor: const Color(
          0xff2C2E36,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  children: [
                    Text(
                      flashcard["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.34,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () => showBadgeDetails(context),
                    child: SvgPicture.asset(
                      (flashcard["badge"] as Map)["path"]
                      [flashcard["currentLevel"] - 1],
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(flashcard["color"]),
                child: Center(
                  child: Text(
                    "Visualization",
                    style: TextStyle(
                      color: const Color(
                        0xffFFFFFF,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                color: Color(flashcard["color"]),
                child: Center(
                  child: Text(
                    "World Economic Forum",
                    style: TextStyle(
                      color: const Color(
                        0xffFFFFFF,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                color: Color(flashcard["color"]),
                child: Center(
                  child: Text(
                    "Read more about Fast Fashion",
                    style: TextStyle(
                      color: const Color(
                        0xffFFFFFF,
                      ),
                    ),
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