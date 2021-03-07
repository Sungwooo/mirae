import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:mirae/components/text_underline.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  Widget build(BuildContext context) {
    var _isCheck1 = false;
    var _isCheck2 = false;
    var _isCheck3 = false;

    int day = 5;
    List<int> fiveList = [5, 4, 3, 2, 1];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CupertinoNavigationBar(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.0, // One physical pixel.
              style: BorderStyle.none,
            ),
          ),
          middle: Text(
            "E - CHALLENGES",
            style:
                TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
          ),
          leading: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              color: Color(0xff31AC53),
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 164,
              decoration: BoxDecoration(
                color: Color(0xff36AE57).withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(54, 174, 87, 0.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 22, left: 29, bottom: 26, right: 52),
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/earth.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Day $day",
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 28,
                              fontFamily: 'GoogleSans'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11, bottom: 8),
                          child: Text(
                            "Today you can burn",
                            style: TextStyle(
                                color: Color(0xffFCE490),
                                fontSize: 16,
                                fontFamily: 'GoogleSans'),
                          ),
                        ),
                        Container(
                          width: 152, // 텍스트의 길이에 따라 맞추어야할듯
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xffFCE596),
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 27.16,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage('assets/running.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 11),
                                child: Text(
                                  "10 calories",
                                  style: TextStyle(
                                      color: Color(0xffFF8A00),
                                      fontSize: 24,
                                      fontFamily: 'GoogleSans'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Container(
                width: 350,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(fiveList.length, (index) {
                        return InkWell(
                          child: (Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Day ${index + 1}",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'GoogleSans')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 26,
                                height: 26,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/challengeCheck.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 12),
              child: Container(
                width: 0.93 * width,
                height: 0.29 * height,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(54, 174, 87, 0.7),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Color(0xff36AE57).withOpacity(0.7),
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
                            Image.asset(
                              'assets/world.png',
                              width: 0.08 * width,
                            ),
                            SizedBox(
                              width: 0.04 * width,
                            ),
                            Text('E - Challenge',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
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
            ),
          ],
        ));
  }
}
