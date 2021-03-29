import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mirae/global.dart';

class MyScoreBoxWidget extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();

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
            int pingNum = values["discard"] + values["ping"];
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: 0.009 * height),
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 0.453 * width,
                        color: Color(0xffCCf795).withOpacity(0.7),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 0.014 * height,
                            bottom: 0.011 * height,
                            left: 0.048 * width,
                            right: 0.048 * width,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/world.png",
                                    color: Color(0xff31AC53),
                                    width: 0.08 * width,
                                  ),
                                  SizedBox(width: 0.01 * width),
                                  Text(
                                    "${pingNum ~/ 10 * 0.1}",
                                    style: TextStyle(
                                        fontFamily: "GoogleSans",
                                        fontSize: 0.09 * width,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff31AC53)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 0.007 * height,
                              ),
                              Text(
                                "years of earth age",
                                style: TextStyle(
                                    fontFamily: "GoogleSans",
                                    fontSize: 0.042 * width,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff31AC53)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.027 * width,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 0.453 * width,
                        color: Color(0xffFFDF6D).withOpacity(0.7),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 0.014 * height,
                            bottom: 0.011 * height,
                            left: 0.048 * width,
                            right: 0.048 * width,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/map/runIcon.png",
                                    color: Color(0xffFF8A00),
                                    height: 0.08 * width,
                                  ),
                                  SizedBox(width: 0.01 * width),
                                  Text(
                                    "${int.parse(values["distance"].toString()) ~/ 45}",
                                    style: TextStyle(
                                        fontFamily: "GoogleSans",
                                        fontSize: 0.09 * width,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFF8A00)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 0.007 * height,
                              ),
                              Text(
                                "burned calories",
                                style: TextStyle(
                                    fontFamily: "GoogleSans",
                                    fontSize: 0.042 * width,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffFF8A00)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
