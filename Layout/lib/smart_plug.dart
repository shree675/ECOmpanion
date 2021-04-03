import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmartPlug extends StatelessWidget {
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
              color: const Color(0xffFF7262),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    "assets/Group 29.svg",
                  ),
                  Text(
                    "SMART PLUG",
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
            "SMART PLUG is a futuristic integrated solution that automatically monitors and reduces electricity in your house. It brings you a whole leap closer to living a sustainable life.",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 18),
          ),
        ],
      ),
    );
  }
}
