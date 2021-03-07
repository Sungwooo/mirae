import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:expansion_card/expansion_card.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  Widget build(BuildContext context) {
    double _width = 330;
    double _height = 260;
    var _isCheck1 = false;
    var _isCheck2 = false;
    var _isCheck3 = false;

    int day = 5;
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
            "E-CHALLENGES",
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
              padding: const EdgeInsets.only(top:27),
              child: Container(
                width: 350,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {_height=0;},
                          child: Container(
                            width: 36,
                            height: 49,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("Day 1", style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontFamily: 'GoogleSans')),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/check.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            day = 2;
                            if (_height == 0)
                              _height = 220;
                            else
                              _height = 0;
                          },
                          child: Container(
                            width: 36,
                            height: 49,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Day 2", style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontFamily: 'GoogleSans')),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/check.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            day = 3;
                            if (_height == 0)
                              _height = 220;
                            else
                              _height = 0;
                          },
                          child: Container(
                            width: 36,
                            height: 49,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("Day 3", style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontFamily: 'GoogleSans')),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/check.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            day = 4;
                            if (_height == 0)
                              _height = 220;
                            else
                              _height = 0;
                          },
                          child: Container(
                            width: 36,
                            height: 49,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("Day 4", style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontFamily: 'GoogleSans')),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/check.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            day = 5;
                            if (_height == 0)
                              _height = 220;
                            else
                              _height = 0;
                          },
                          child: Container(
                            width: 36,
                            height: 49,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("Day 5", style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontFamily: 'GoogleSans')),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/check.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      width: _width,
                      height: _height,
                      duration: Duration(),
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(3, 3)),
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(-3, -3)),
                        ],
                        color: Color(0xff42B261),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow
                      ),
                      child: Column(
                        children: [
                          Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 82.0, top: 11.0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/world.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 14.0),
                              child: Text('E - Challenge',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'GoogleSans')),
                            )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 13.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/circle1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 16),
                                    child: Container(
                                      width: 210,
                                      child: Text('Using a tumbler',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily:
                                              'GoogleSans')),
                                    )),
                                Column(children: [
                                  Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.green,
                                    value: _isCheck1,
                                    onChanged: (value) {
                                      setState(() {
                                        _isCheck1 = value;
                                      });
                                    },
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 13.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/circle2.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 16),
                                    child: Container(
                                      width: 210,
                                      child: Text(
                                          'Donating items you don\'t use at home',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily:
                                              'GoogleSans')),
                                    )),
                                Column(children: [
                                  Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.green,
                                    value: _isCheck2,
                                    onChanged: (value) {
                                      setState(() {
                                        _isCheck2 = value;
                                      });
                                    },
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 13.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/circle3.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 16),
                                    child: Container(
                                      width: 210,
                                      child: Text(
                                          'Using public transportation',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily:
                                              'GoogleSans')),
                                    )),
                                Column(children: [
                                  Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.green,
                                    value: _isCheck3,
                                    onChanged: (value) {
                                      setState(() {
                                        _isCheck3 = value;
                                      });
                                    },
                                  ),
                                ]),
                              ],
                            ),
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
