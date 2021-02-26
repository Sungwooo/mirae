import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:mirae/map/ping_map.dart';

class LetsGoWidget extends StatefulWidget {
  LetsGoWidget({this.pingMapState});
  final PingMapState pingMapState;
  @override
  _LetsGoWidgetState createState() => _LetsGoWidgetState();
}

class _LetsGoWidgetState extends State<LetsGoWidget> {
  bool showBottomMenu = false;
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
      bottom: (showBottomMenu) ? -60 : -(height * 2 / 5) + 30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: width,
          height: (height * 2 / 5),
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
                        width: 40,
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
                              padding: const EdgeInsets.only(left: 15),
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
                                  width: 40,
                                  height: 40,
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
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConditionalSwitch.single<String>(
                                context: context,
                                valueBuilder: (BuildContext context) =>
                                    turnIcon,
                                caseBuilders: {
                                  'left': (BuildContext context) => Icon(
                                        Icons.arrow_back,
                                        size: 45,
                                        color: Color(0xff36AE57),
                                      ),
                                  'right': (BuildContext context) => Icon(
                                        Icons.arrow_forward,
                                        size: 45,
                                        color: Color(0xff36AE57),
                                      ),
                                },
                                fallbackBuilder: (BuildContext context) => Icon(
                                  Icons.arrow_upward,
                                  size: 45,
                                  color: Color(0xff36AE57),
                                ),
                              ),
                              Text(
                                "${widget.pingMapState.navigateMsg}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
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
                          width: 26,
                          height: 26,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
            width: 105,
            height: 80,
            color: backgroundColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Image.asset(
                      imagePath,
                      width: 26,
                      height: 26,
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
