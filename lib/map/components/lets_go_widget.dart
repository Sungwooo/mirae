import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:mirae/map/components/ping_map.dart';

class LetsGoWidget extends StatefulWidget {
  LetsGoWidget({this.pingMapState});
  final PingMapState pingMapState;
  @override
  _LetsGoWidgetState createState() => _LetsGoWidgetState();
}

class _LetsGoWidgetState extends State<LetsGoWidget> {
  bool showBottomMenu = true;
  int markerNum = 3;
  int trashNum = 5;
  String turnIcon = "";

  void setDirectionIcon() {
    if (widget.pingMapState.navigateMsg != null) {
      String checkMsg = widget.pingMapState.navigateMsg;
      if (checkMsg.contains('Turn left')) {
        setState(() {
          turnIcon = "left";
        });
      } else if (checkMsg.contains('Turn right')) {
        setState(() {
          turnIcon = "right";
        });
      } else {
        setState(() {
          turnIcon = "straight";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setDirectionIcon();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      left: 0,
      bottom: (showBottomMenu) ? -60 : -(height * 3 / 7) + 30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: width,
          height: (height * 3 / 7),
          color: Colors.white.withOpacity(0.7),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 11,
                    child: FlatButton(
                      child: Image.asset(
                        "assets/icon/map/downButton.png",
                        width: width * 0.1,
                        height: 5,
                      ),
                      onPressed: () {
                        setState(() {
                          showBottomMenu = !showBottomMenu;
                        });
                      },
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.04),
                              child: Row(
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: "GoogleSans",
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icon/map/myMarker.png",
                                  width: width * 0.1,
                                  height: width * 0.1,
                                ),
                                Text(
                                  "$markerNum",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConditionalSwitch.single<String>(
                                  context: context,
                                  valueBuilder: (BuildContext context) =>
                                      turnIcon,
                                  caseBuilders: {
                                    'left': (BuildContext context) =>
                                        Image.asset(
                                          "assets/icon/map/cornerLeft.png",
                                          width: width * 0.1,
                                          height: width * 0.1,
                                        ),
                                    'right': (BuildContext context) =>
                                        Image.asset(
                                          "assets/icon/map/cornerRight.png",
                                          width: width * 0.1,
                                          height: width * 0.1,
                                        ),
                                  },
                                  fallbackBuilder: (BuildContext context) =>
                                      Image.asset(
                                    "assets/icon/map/straight.png",
                                    width: width * 0.1,
                                    height: width * 0.1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${widget.pingMapState.navigateMsg}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "GoogleSans",
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Expected Rewards",
                      style: TextStyle(
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getEffect(
                          Color(0xffCCF795),
                          "assets/icon/map/worldIcon.png",
                          'save world',
                          Color(0xff31AC53)),
                      getEffect(
                          Color(0xffFFDF6D),
                          "assets/icon/map/runIcon.png",
                          '-30kcal',
                          Color(0xffFF8A00)),
                      getEffect(
                          Color(0xff96F2FF),
                          "assets/icon/map/pointIcon.png",
                          '+ 40 points',
                          Color(0xff1B91FF)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/map/trashMarker.png",
                          width: width * 0.07,
                          height: width * 0.07,
                        ),
                        Text(
                          "There are $trashNum trashes nearby",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getEffect(
      Color backgroundColor, String imagePath, String value, Color fontColor) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
            width: width * 0.27,
            height: height * 0.1,
            color: backgroundColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Image.asset(
                      imagePath,
                      width: width * 0.07,
                      height: width * 0.07,
                    ),
                  ),
                  Text(
                    '$value',
                    style: TextStyle(
                      color: fontColor,
                      fontFamily: "GoogleSans",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ])),
      ),
    );
  }
}
