import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../global.dart';

class ProgressBarWidget extends StatefulWidget {
  @override
  _ProgressBarWidgetState createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  final dbRef = FirebaseDatabase.instance.reference();
  int points = 54400;
  double barPercent;

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
            return Center();
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

            points = values["point"];
            Globals.changePoints(points);
            barPercent = points > 20000
                ? (points - 20000) / 50000
                : points > 5000
                    ? (points - 5000) / 20000
                    : points / 5000;

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: 0.009 * height),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffB1ECFF),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.06 * width, vertical: 0.02 * height),
                  child: Column(
                    children: [
                      Container(
                        height: 0.15 * height,
                        width: 0.8 * width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: 0.22 * width,
                                height: points > 5000
                                    ? 0.285 * width
                                    : 0.285 * width * (points / 5000),
                                child: points > 0
                                    ? Image.asset(
                                        'assets/levelTreeIcon.png',
                                        alignment: Alignment.bottomCenter,
                                      )
                                    : Container()),
                            Container(
                                width: 0.22 * width,
                                height: points > 5000
                                    ? 0.285 * width * ((points - 5000) / 20000)
                                    : 0,
                                child: points > 5000
                                    ? Image.asset(
                                        'assets/levelTreeIcon.png',
                                        alignment: Alignment.bottomCenter,
                                      )
                                    : Container()),
                            Container(
                                width: 0.22 * width,
                                height: points > 20000
                                    ? 0.285 * width * ((points - 20000) / 70000)
                                    : 0,
                                child: points > 20000
                                    ? Image.asset(
                                        'assets/levelTreeIcon.png',
                                        alignment: Alignment.bottomCenter,
                                      )
                                    : Container()),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.8 * width,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.64 * barPercent,
                            bottom: 4,
                          ),
                          child: Text(
                            "${numberWithComma(points)} pts",
                            style: TextStyle(
                                fontFamily: "GoogleSans",
                                fontSize: 0.032 * width,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        height: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                              backgroundColor: Color(0xffD3D3D3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff31AC53)),
                              value: barPercent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
