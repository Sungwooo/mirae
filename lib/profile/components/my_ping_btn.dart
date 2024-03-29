import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mirae/global.dart';

class MyPingButtonWidget extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();
  String numberWithComma(int param) {
    return new NumberFormat('###,###,###,###')
        .format(param)
        .replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: dbRef.child("user").child(Globals.uid).once(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 0.04 * width),
              ),
            );
          } else {
            Map<dynamic, dynamic> values = snapshot.data.value;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: 0.009 * height),
              child: Container(
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
                            Container(
                              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                              child: Text(
                                "DISCARD",
                                style: TextStyle(
                                    color: Color(0xff393939),
                                    fontFamily: "GoogleSans",
                                    fontSize: 0.032 * width,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 0.04 * width,
                        ),
                        Text(
                          "${numberWithComma(values["discard"])}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 0.064 * width,
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
                            Container(
                              transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                              child: Text(
                                "PING",
                                style: TextStyle(
                                    color: Color(0xff393939),
                                    fontFamily: "GoogleSans",
                                    fontSize: 0.032 * width,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 0.04 * width,
                        ),
                        Text(
                          "${numberWithComma(values["ping"])}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "GoogleSans",
                              fontSize: 0.064 * width,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}


