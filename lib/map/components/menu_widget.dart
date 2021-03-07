import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/map/components/lets_go_map.dart';
import 'package:mirae/map/components/ping_map.dart';
import 'package:latlong/latlong.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({this.pingMapState});
  final PingMapState pingMapState;
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int distance = 100;
  bool showBottomMenu = true;

  final Distance calDistance = Distance();

  getTrashDistance() {
    double meter = calDistance(
        LatLng(widget.pingMapState.location.latitude,
            widget.pingMapState.location.longitude),
        LatLng(widget.pingMapState.destination.latitude,
            widget.pingMapState.destination.longitude));
    setState(() {
      distance = meter.floor();
    });
  }

  @override
  Widget build(BuildContext context) {
    getTrashDistance();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      left: 0,
      bottom: (showBottomMenu) ? -60 : -(height * 4 / 9) + 35,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: width,
          height: (height * 4 / 9) + 25,
          color: Colors.white.withOpacity(0.7),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                          Color(0xffCCF795).withOpacity(0.7),
                          "assets/icon/map/worldIcon.png",
                          'save world',
                          Color(0xff31AC53)),
                      getEffect(
                          Color(0xffFFDF6D).withOpacity(0.7),
                          "assets/icon/map/runIcon.png",
                          '-30kcal',
                          Color(0xffFF8A00)),
                      getEffect(
                          Color(0xff96F2FF).withOpacity(0.7),
                          "assets/icon/map/pointIcon.png",
                          '+ 40 points',
                          Color(0xff1B91FF)),
                    ],
                  ),
                  Container(
                    width: width * 0.65,
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
                  ),
                  Stack(children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0.03 * height),
                        child: FlatButton(
                            child: Image.asset(
                              "assets/icon/map/letsGoBtn.png",
                              width: width * 0.3,
                              height: width * 0.3,
                            ),
                            onPressed: () {
                              widget.pingMapState.sendRequest();
                              Get.to(() => LetsGoMapPage());
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: FlatButton(
                        onPressed: null,
                        child: Text("Next time",
                            style: TextStyle(
                                color: Color(0xffF3A932),
                                fontFamily: "GoogleSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ]),
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
