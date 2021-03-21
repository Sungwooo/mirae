import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/auth_page.dart';

class DiscardSplash extends StatefulWidget {
  @override
  _DiscardSplashState createState() => new _DiscardSplashState();
}

class _DiscardSplashState extends State<DiscardSplash> {
  startTime() async {
    var _duration = new Duration(milliseconds: 150);
    return new Timer(_duration,
        () => Get.offAll(() => AuthPage(), transition: Transition.fade));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Thank you for DISCARD",
                  style: TextStyle(
                      fontSize: 0.074 * width,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans",
                      color: Color(0xff31AC53)),
                ),
                SizedBox(
                  height: 48,
                ),
                Image.asset(
                  "assets/splashCheck.png",
                  width: 86,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "+ 40 points",
                  style: TextStyle(
                      fontSize: 0.048 * width,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans",
                      color: Color(0xff31AC53)),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Waiting for you to DISCARD",
                  style: TextStyle(
                      fontSize: 0.053 * width,
                      fontWeight: FontWeight.w700,
                      fontFamily: "GoogleSans",
                      color: Color(0xff333333)),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/map/trashMarker.png",
                      width: 60,
                    ),
                    Text(
                      "1030",
                      style: TextStyle(
                          fontSize: 0.058 * width,
                          fontWeight: FontWeight.w700,
                          fontFamily: "GoogleSans",
                          color: Color(0xffF4C623)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
