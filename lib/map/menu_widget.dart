import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirae/map/ping_map.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({this.pingMapState});
  final PingMapState pingMapState;
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int distance = 100;
  bool showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      left: 0,
      bottom: (showBottomMenu) ? -60 : -(height * 4 / 9) + 30,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: width,
          height: (height * 4 / 9) + 25,
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "There is other trash near ${distance}m",
                    style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "You can get",
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
                      padding: EdgeInsets.only(top: 10, bottom: 0),
                      child: Container(
                        width: 230,
                        child: Text(
                          "Picking up trash can save the environment and save 30 calories",
                          style: TextStyle(
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff31AC53),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                          child: Image.asset(
                            "assets/icon/map/nextTimeBt.png",
                            width: 110,
                            height: 110,
                          ),
                          onPressed: null),
                      FlatButton(
                          child: Image.asset(
                            "assets/icon/map/letsGoBt.png",
                            width: 110,
                            height: 110,
                          ),
                          onPressed: () {
                            widget.pingMapState.sendRequest();
                            widget.pingMapState.togglePingWidget();
                          }),
                    ],
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
