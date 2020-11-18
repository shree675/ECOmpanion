import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Ecommunity extends StatelessWidget {
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
          Container(
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
          SizedBox(
            height: 10,
          ),
          const Text(
            "COMING SOON!",
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          const Text(
            "ECOmmunity shows you how you and everyone else on ECOmpanion is making a difference, one step at a time, one individual at a time, making a more sustainable community.",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 18),
          ),
        ],
      ),
    );
  }
}
