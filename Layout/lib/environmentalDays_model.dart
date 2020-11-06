import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class EnvironmentalDayCard extends StatelessWidget {
  final Map environmentalDayData;
  EnvironmentalDayCard(this.environmentalDayData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ExpansionTileCard(
        baseColor: const Color(0xff93C47D),
        expandedColor: const Color(0xff93C47D),
        borderRadius: BorderRadius.circular(10),
        trailing: Container(
          height: 0,
          width: 0,
        ),
        title: Text(
          environmentalDayData["title"],
          style: TextStyle(color: Colors.white),
        ),
        children: [
          ...(environmentalDayData["description"] as List)
              .map((line) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      line,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
              .toList(),
          ...(environmentalDayData["links"] as List).map((link) {
            return FlatButton(
              onPressed: () {},
              child: Text(
                link["text"],
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlueAccent,
            );
          })
        ],
      ),
    );
  }
}
