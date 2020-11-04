// import 'package:Layout/models/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'details.dart';

class Flashcard extends StatefulWidget {
  final Map flashcard;
  Flashcard(this.flashcard);
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  // final double unexpandedBadgeSize = 50;
  // final double expandedBadgeSize = 100;
  // double badgeSize;

  void showDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Details(widget.flashcard);
    }));
  }

  @override
  Widget build(BuildContext context) {
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
          trailing: SvgPicture.asset(
            (widget.flashcard["badge"] as Map)["path"]
                [(widget.flashcard["currentLevel"] as int) - 1],
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

          baseColor: Color(
            widget.flashcard["color"],
          ),
          expandedColor: Color(
            widget.flashcard["color"],
          ),
          title: Row(
            children: [
              Text(
                widget.flashcard["title"],
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
                widget.flashcard["shortDescription"],
                style: TextStyle(
                  color: const Color(
                    0xffFFFFFF,
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
