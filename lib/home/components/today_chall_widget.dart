import 'package:flutter/material.dart';
import 'package:mirae/components/text_underline.dart';
import 'package:mirae/home/challenge.dart';

class ChallengeWidget extends StatefulWidget {
  ChallengeWidget({this.challengeState});
  final ChallengeState challengeState;
  @override
  _ChallengeWidgetState createState() => _ChallengeWidgetState();
}

class _ChallengeWidgetState extends State<ChallengeWidget> {
  var _isCheck1 = false;
  var _isCheck2 = false;
  var _isCheck3 = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 120),
        width: 0.93 * width,
        height: 0.29 * height,
        decoration: BoxDecoration(
          color: Color(0xff36AE57),
          borderRadius: BorderRadius.circular(10),
          // boxShadow
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.018 * height),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Day ${widget.challengeState.day}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 0.053 * width,
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
                            message: "Using a tumbler",
                          )),
                      Column(children: [
                        InkWell(
                          onTap: () => setState(() {
                            _isCheck1 = !_isCheck1;
                          }),
                          child: _isCheck1
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                            message: "Donate items you don\'t use",
                          )),
                      Column(children: [
                        InkWell(
                          onTap: () => setState(() {
                            _isCheck2 = !_isCheck2;
                          }),
                          child: _isCheck2
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                            message: 'Using public transportation'),
                      ),
                      Column(children: [
                        InkWell(
                          onTap: () => setState(() {
                            _isCheck3 = !_isCheck3;
                          }),
                          child: _isCheck3
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
