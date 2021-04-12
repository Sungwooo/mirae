import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mirae/global.dart';

import 'package:mirae/map/map.dart';

class MapSplash extends StatefulWidget {
  @override
  _MapSplashState createState() => new _MapSplashState();
}

class _MapSplashState extends State<MapSplash> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int userPoint;
  int userPing;
  Location _locationTracker = Location();
  LocationData location;

  makeNewPing() async {
    location = await _locationTracker.getLocation();
    await databaseReference.child("ping").push().set({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'uid': Globals.uid,
    });
  }

  Future<void> getUserData() async {
    await databaseReference
        .child('user')
        .child(Globals.uid)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      if (values.isNotEmpty) {
        {
          values.forEach((key, values) {
            if (key == "point") {
              userPoint = int.parse(values.toString());
            }
            if (key == "ping") {
              userPing = int.parse(values.toString());
            }
          });
        }
      }
    });
  }

  updateUserData() async {
    await getUserData();
    if (userPoint != null && userPing != null) {
      await databaseReference
          .child('user')
          .child(Globals.uid)
          .update({'point': userPoint + 20, 'ping': userPing + 1});
    }
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 1500);
    return new Timer(_duration, () async {
      await updateUserData();
      await makeNewPing();
      Get.offAll(() => MapPage(true), transition: Transition.fade);
    });
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
                  "Thank you for PING",
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
                  "+ 20 points",
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
