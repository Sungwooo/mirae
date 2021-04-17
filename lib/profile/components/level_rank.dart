import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:intl/intl.dart';

import '../../global.dart';

var now = DateFormat('y.MM.dd').format(DateTime.now());

class LevelRankWidget extends StatelessWidget {
  final FirebaseProvider fp;
  LevelRankWidget({this.fp});
  @override
  Widget build(BuildContext context) {
    FirebaseUser currentUser = fp.getUser();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 0.346 * width,
      decoration: BoxDecoration(
        color: Color(0xff36AE57).withOpacity(0.8),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(54, 174, 87, 0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 0.03 * height,
            bottom: 0.01 * height,
            left: 0.04 * width,
            right: 0.1 * width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/world.png",
                  width: width * 0.1,
                ),
                SizedBox(
                  width: 0.02 * width,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Day ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(currentUser.metadata.creationTime).inDays + 1}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 0.08 * width,
                          fontWeight: FontWeight.w700),
                    ),
                    Image.asset(
                      "assets/profileUnderline.png",
                      width: 0.23 * width,
                      height: 0.01 * height,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Level",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 0.037 * width,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 0.02 * width),
                    Text(
                      Globals.points >= 20000
                          ? "GREEN"
                          : Globals.points >= 5000
                              ? "BLUE"
                              : "ORANGE",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 0.053 * width,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rank",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 0.037 * width,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 0.02 * width),
                    Text(
                      '${Globals.rank}',
                      style: TextStyle(
                          color: Color(0xffFCE596),
                          fontFamily: "GoogleSans",
                          fontSize: 0.058 * width,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
