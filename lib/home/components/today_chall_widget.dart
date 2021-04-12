import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/components/text_underline.dart';
import 'package:mirae/global.dart';
import 'package:mirae/home/challenge.dart';
import 'package:mirae/home/controller/challenge_controller.dart';
import 'package:mirae/home/home_page.dart';

class ChallengeWidget extends StatefulWidget {
  ChallengeWidget({
    this.challengeState,
  });
  final ChallengeState challengeState;
  @override
  _ChallengeWidgetState createState() => _ChallengeWidgetState();
}

class _ChallengeWidgetState extends State<ChallengeWidget> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('userChallenges');
  List challengeList = [
    [
      "Unplug unused products",
      "Reduce using hot water",
      "Don't use disposables"
    ],
    [
      "Don’t use a dryer",
      "Trade used without buying",
      "Taking a walk(no cars)",
    ],
    [
      "Seperate collection",
      "Collecting the laundry",
      "Finding the origin of food",
    ],
    [
      "Don\'t get delivered",
      "Growing plants",
      "Shower in 5 minutes",
    ],
    [
      "Using a tumbler",
      "Donate items you don\'t use",
      'Using public transportation',
    ]
  ];

  final ChallengeController challengeController =
      Get.put(ChallengeController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() => (Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: 0.032 * width),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 120),
            width: 0.93 * width,
            height: 0.29 * height,
            decoration: BoxDecoration(
              color: Color(0xff36AE57).withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff36AE57).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
              // boxShadow
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.018 * height),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            widget.challengeState.day == 0
                                ? ''
                                : 'Day ${widget.challengeState.day}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 0.064 * width,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GoogleSans')),
                      ]),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/circle1.png',
                            width: 0.07 * width,
                          ),
                          Container(
                              width: 0.65 * width,
                              child: TextUnderline(
                                message:
                                    "${challengeList[widget.challengeState.day % 5][0]}",
                              )),
                          Column(children: [
                            InkWell(
                              onTap: () => setState(() {
                                if (challengeController.checkedOne == false) {
                                  challengeController.checkedValue = 1;
                                  uploadCheck(
                                      challengeController.checkedOne == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedTwo == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedThree == true
                                          ? 1
                                          : 0);
                                }
                              }),
                              child: challengeController.checkedOne == true
                                  ? Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/homeChecked.png",
                                            width: 0.07 * width,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "+ 20 points",
                                            style: TextStyle(
                                                fontFamily: "GoogleSans",
                                                fontSize: 0.021 * width,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/homeUnChecked.png",
                                            width: 0.07 * width,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/circle2.png',
                            width: 0.07 * width,
                          ),
                          Container(
                              width: 0.65 * width,
                              child: TextUnderline(
                                message:
                                    "${challengeList[widget.challengeState.day % 5][1]}",
                              )),
                          Column(children: [
                            InkWell(
                              onTap: () => setState(() {
                                if (challengeController.checkedTwo == false) {
                                  challengeController.checkedValue = 2;
                                  uploadCheck(
                                      challengeController.checkedOne == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedTwo == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedThree == true
                                          ? 1
                                          : 0);
                                }
                              }),
                              child: challengeController.checkedTwo == true
                                  ? Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/homeChecked.png",
                                            width: 0.07 * width,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "+ 20 points",
                                            style: TextStyle(
                                                fontFamily: "GoogleSans",
                                                fontSize: 0.021 * width,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/homeUnChecked.png",
                                            width: 0.07 * width,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/circle3.png',
                            width: 0.07 * width,
                          ),
                          Container(
                            width: 0.65 * width,
                            child: TextUnderline(
                                message:
                                    "${challengeList[widget.challengeState.day % 5][2]}"),
                          ),
                          Column(children: [
                            InkWell(
                              onTap: () => setState(() {
                                if (challengeController.checkedThree == false) {
                                  challengeController.checkedValue = 3;
                                  uploadCheck(
                                      challengeController.checkedOne == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedTwo == true
                                          ? 1
                                          : 0,
                                      challengeController.checkedThree == true
                                          ? 1
                                          : 0);
                                }
                              }),
                              child: challengeController.checkedThree == true
                                  ? Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/homeChecked.png",
                                            width: 0.07 * width,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "+ 20 points",
                                            style: TextStyle(
                                                fontFamily: "GoogleSans",
                                                fontSize: 0.021 * width,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 0.15 * width,
                                      height: 0.05 * height,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/homeUnChecked.png",
                                            width: 0.07 * width,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  void uploadCheck(int one, int two, int three) async {
    await databaseReference.child(Globals.uid).update({
      '${Globals.today}': [one, two, three]
    });
  }
}
