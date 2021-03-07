import 'package:flutter/material.dart';

class MyPingButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: 0.009 * height),
      child: Container(
        height: 0.1 * height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              image: AssetImage("assets/profilePingBackground.png"),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
              color: Color(0xffA79F84),
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/discardIcon.png",
                      width: 0.16 * width,
                    ),
                    Text(
                      "DISCARD",
                      style: TextStyle(
                          color: Color(0xff393939),
                          fontFamily: "GoogleSans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  width: 0.04 * width,
                ),
                Text(
                  "124",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "GoogleSans",
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/myPingIcon.png",
                      width: 0.16 * width,
                    ),
                    Text(
                      "PING",
                      style: TextStyle(
                          color: Color(0xff393939),
                          fontFamily: "GoogleSans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  width: 0.04 * width,
                ),
                Text(
                  "378",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "GoogleSans",
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}