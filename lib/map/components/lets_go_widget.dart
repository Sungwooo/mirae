import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:mirae/camera/camera.dart';
import 'package:mirae/global.dart';
import 'package:mirae/login/auth_page.dart';
import 'package:mirae/main.dart';
import 'package:mirae/map/components/ping_map.dart';

class LetsGoWidget extends StatefulWidget {
  LetsGoWidget({this.pingMapState});
  final PingMapState pingMapState;

  @override
  _LetsGoWidgetState createState() => _LetsGoWidgetState();
}

class _LetsGoWidgetState extends State<LetsGoWidget> {
  final databaseReference = FirebaseDatabase.instance.reference().child('user');

  bool showBottomMenu = true;
  int markerNum = 3;
  int trashNum = 5;
  String turnIcon = "";
  int userDistance = 0;
  int userPoint = 0;
  int distance = 100;

  final Distance calDistance = Distance();

  Future<void> getUserDistance() async {
    await databaseReference
        .child(Globals.uid)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      if (values.isNotEmpty) {
        {
          values.forEach((key, values) {
            if (key == "distance") {
              userDistance = int.parse(values.toString());
            }
            if (key == "point") {
              userPoint = int.parse(values.toString());
            }
          });
        }
      }
    });
  }

  getMoveDistance() {
    double meter = calDistance(
        LatLng(widget.pingMapState.location.latitude,
            widget.pingMapState.location.longitude),
        LatLng(widget.pingMapState.destination.latitude,
            widget.pingMapState.destination.longitude));

    distance = meter.floor();
  }

  void updateUserDistance(int distance) async {
    await getUserDistance();
    print("${userDistance + distance}");
    await databaseReference
        .child(Globals.uid)
        .update({'distance': userDistance + distance, 'point': userPoint + 40});
  }

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
    getMoveDistance();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      left: 0,
      bottom: (showBottomMenu
          ? (widget.pingMapState.isArrived
              ? -(width * 0.24) + 30
              : -(0.515 * width) + 30)
          : ((widget.pingMapState.isArrived)
              ? -(1.2 * width) + 30
              : -(0.928 * width) + 30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: width,
          height: 1.2 * width,
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
                              padding: EdgeInsets.only(left: width * 0.025),
                              child: Row(
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 0.021 * width,
                                        fontFamily: "GoogleSans",
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.left,
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
                                      fontSize: 0.032 * width,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: widget.pingMapState.isArrived
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Image.asset(
                                        "assets/icon/map/arrivedIcon.png",
                                        width: width * 0.15,
                                        height: width * 0.15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Text(
                                          "Arrived",
                                          style: TextStyle(
                                              fontSize: 0.058 * width,
                                              fontFamily: "GoogleSans",
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ])
                              : Column(
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
                                        fallbackBuilder:
                                            (BuildContext context) =>
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
                                              fontSize: 0.058 * width,
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
                          fontSize: 0.032 * width),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getEffect(
                          Color(0xffCCF795).withOpacity(0.7),
                          "assets/icon/map/worldIcon.png",
                          'save world',
                          Color(0xff31AC53)),
                      getEffect(
                          Color(0xffFFDF6D).withOpacity(0.7),
                          "assets/icon/map/runIcon.png",
                          '-${distance ~/ 45}kcal',
                          Color(0xffFF8A00)),
                      getEffect(
                          Color(0xff96F2FF).withOpacity(0.7),
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
                              fontSize: 0.037 * width,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  widget.pingMapState.isArrived
                      ? Padding(
                          padding: EdgeInsets.only(top: height * 0.006),
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.03 * height),
                                child: TextButton(
                                  onPressed: () {
                                    getMoveDistance();
                                    print("${distance ~/ 45}");
                                    updateUserDistance(distance);
                                    Get.to(() => CameraPage(cameras));
                                  },
                                  child: Image.asset(
                                    "assets/icon/map/arrivedCamera.png",
                                    width: 0.27 * width,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: TextButton(
                                onPressed: () => Get.offAll(() => AuthPage()),
                                child: Text("Next time",
                                    style: TextStyle(
                                        color: Color(0xffF3A932),
                                        fontFamily: "GoogleSans",
                                        fontSize: 0.042 * width,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ]),
                        )
                      : Container(),
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
                      fontSize: 0.034 * width,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ])),
      ),
    );
  }
}
