import 'package:flutter/material.dart';
import 'package:mirae/components/text_underline.dart';
import 'package:mirae/home/challenge.dart';

class BeforeChallWidget extends StatefulWidget {
  BeforeChallWidget({this.challengeState});
  final ChallengeState challengeState;
  @override
  _BeforeChallWidgetState createState() => _BeforeChallWidgetState();
}

class _BeforeChallWidgetState extends State<BeforeChallWidget> {
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
      "Do not deliver",
      "Growing plants",
      "Shower in 5 minutes",
    ],
    [
      "Using a tumbler",
      "Donate items you don\'t use",
      'Using public transportation',
    ]
  ];

  var _isCheck1 = true;
  var _isCheck2 = true;
  var _isCheck3 = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: 0.032 * width),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 120),
        width: 0.93 * width,
        height: 0.29 * height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff42B261)),
          borderRadius: BorderRadius.circular(10),
          // boxShadow
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.01 * height),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        widget.challengeState.selectedDay == 0
                            ? ""
                            : 'Day ${widget.challengeState.selectedDay}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
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
                        color:
                            _isCheck1 ? Color(0xff42B261) : Color(0xff797979),
                        width: 0.07 * width,
                      ),
                      Container(
                          width: 0.65 * width,
                          child: TextUnderline(
                            message:
                                "${challengeList[widget.challengeState.selectedDay % 5][0]}",
                            color: _isCheck1
                                ? Color(0xff42B261)
                                : Color(0xff797979),
                          )),
                      Column(children: [
                        _isCheck1
                            ? Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeCheck.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeFailed.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
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
                        color:
                            _isCheck2 ? Color(0xff42B261) : Color(0xff797979),
                      ),
                      Container(
                          width: 0.65 * width,
                          child: TextUnderline(
                            message:
                                "${challengeList[widget.challengeState.selectedDay % 5][1]}",
                            color: _isCheck2
                                ? Color(0xff42B261)
                                : Color(0xff797979),
                          )),
                      Column(children: [
                        _isCheck2
                            ? Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeCheck.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeFailed.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
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
                        color:
                            _isCheck3 ? Color(0xff42B261) : Color(0xff797979),
                      ),
                      Container(
                        width: 0.65 * width,
                        child: TextUnderline(
                          message:
                              "${challengeList[widget.challengeState.selectedDay % 5][2]}",
                          color:
                              _isCheck3 ? Color(0xff42B261) : Color(0xff797979),
                        ),
                      ),
                      Column(children: [
                        _isCheck3
                            ? Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeCheck.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: 0.15 * width,
                                height: 0.05 * height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/challengeFailed.png",
                                      width: 0.07 * width,
                                    ),
                                  ],
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
    );
  }
}
