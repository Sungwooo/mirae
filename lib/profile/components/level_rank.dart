import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:intl/intl.dart';

var now = DateFormat('y.MM.dd').format(DateTime.now());

class LevelRankWidget extends StatelessWidget {
  FirebaseProvider fp;
  LevelRankWidget({this.fp});
  FirebaseUser currentUser;
  @override
  Widget build(BuildContext context) {
    currentUser = fp.getUser();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 0.16 * height,
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
                      "Day ${DateTime.now().difference(currentUser.metadata.creationTime).inDays + 2}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 30,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 0.02 * width),
                    Text(
                      "GREEN",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 20,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 0.02 * width),
                    Text(
                      "146",
                      style: TextStyle(
                          color: Color(0xffFCE596),
                          fontFamily: "GoogleSans",
                          fontSize: 22,
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
