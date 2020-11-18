import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BreatheIn extends StatelessWidget {
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
              color: const Color(0xffFF4F6A),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    "assets/Group 30.svg",
                  ),
                  Text(
                    "BREATHE IN",
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
            "BREATHE IN provides an estimate of your indoor air quality and gives you tips on maintaining it in a carbon negative manner.",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 18),
          ),
        ],
      ),
    );
  }
}
