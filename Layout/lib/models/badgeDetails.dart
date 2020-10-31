import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data.dart';

class BadgeDetailsScreen extends StatelessWidget {
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
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: SvgPicture.asset(
              (data[0]["badge"] as Map)["path"]
                  [(data[0]["currentLevel"] as int) - 1],
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (data[0]["badge"] as Map)["name"],
            style: TextStyle(
              fontSize: 24,
              color: const Color(
                0xffFFFFFF,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "LEVEL " + (data[0]["currentLevel"]).toString(),
            style: TextStyle(
              fontSize: 20,
              color: const Color(
                0xffFFFFFF,
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Card(
              color: const Color(0xffFF7262),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.36,
                padding: const EdgeInsets.all(26),
                child: Column(
                  children: [
                    Text(
                      (data[0]["badge"] as Map)["details"]["title"],
                      style: TextStyle(
                        fontSize: 24,
                        color: const Color(
                          0xffFFFFFF,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        (data[0]["badge"] as Map)["details"]["subtitle"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: const Color(
                            0xffFFFFFF,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
