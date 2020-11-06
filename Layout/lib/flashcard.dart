// import 'package:Layout/models/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'details.dart';
import 'flashcard_model.dart';

class Flashcard extends StatefulWidget {
  final FlashcardModel flashcardModel;
  Flashcard(this.flashcardModel);
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  // final double unexpandedBadgeSize = 50;
  // final double expandedBadgeSize = 100;
  // double badgeSize;

  void showDetailsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Details(widget.flashcardModel);
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
            widget.flashcardModel.badge["path"]
                [widget.flashcardModel.currentLevel - 1],
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
          ],
        ),
      ),
    );
  }
}
