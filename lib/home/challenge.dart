import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/home/components/before_chall_widget.dart';
import 'package:mirae/home/components/today_chall_widget.dart';
import 'package:mirae/home/components/expand_section.dart';

import 'package:mirae/login/firebase_provider.dart';
import 'package:provider/provider.dart';

class Challenge extends StatefulWidget {
  @override
  ChallengeState createState() => ChallengeState();
}

class ChallengeState extends State<Challenge> {
  FirebaseProvider fp;

  bool isBeforeExpanded = false;
  bool isTodayExpanded = false;
  int selectedDay = 0;
  int day = 5;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    fp = Provider.of<FirebaseProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    day = fp != null
        ? DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .difference(fp.getUser().metadata.creationTime)
                .inDays +
            1
        : 5;
    List<int> fourList = [1, 1, 1, 1];
    List<int> fiveList = [1, 1, 1, 1, 1];
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
          padding: EdgeInsetsDirectional.only(),
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
        body: Column(
          children: [
            Container(
              height: 0.2 * height,
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
                    padding: EdgeInsets.only(
                        top: 0.027 * height,
                        left: 0.077 * width,
                        bottom: 0.032 * height,
                        right: 0.138 * width),
                    child: Container(
                      width: 0.14 * height,
                      height: 0.14 * height,
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
                              fontSize: 0.074 * width,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'GoogleSans'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.013 * height, bottom: 0.01 * height),
                          child: Text(
                            "Today you can burn",
                            style: TextStyle(
                                color: Color(0xffFCE490),
                                fontSize: 0.042 * width,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'GoogleSans'),
                          ),
                        ),
                        Container(
                          width: 0.405 * width, // 텍스트의 길이에 따라 맞추어야할듯
                          height: 0.054 * height,
                          decoration: BoxDecoration(
                            color: Color(0xffFCE596),
                            borderRadius: BorderRadius.circular(10),
                            // boxShadow
                          ),

                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 0.02 * height),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/running.png',
                                  height: 0.034 * height,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 0.03 * width),
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                            color: Color(0xffFF8A00),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 0.064 * width,
                                            fontFamily: 'GoogleSans'),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0.01 * width),
                                  child: Text(
                                    "calories",
                                    style: TextStyle(
                                        color: Color(0xffFF8A00),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 0.042 * width,
                                        fontFamily: 'GoogleSans'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                controller: _scrollController,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.05,
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: 0.94 * width,
                            child: Column(
                              children:
                                  List.generate((day + 4) ~/ 5 - 1, (line) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(5, (indexb) {
                                    return InkWell(
                                      onTap: () => setState(() {
                                        isTodayExpanded = false;
                                        selectedDay == line * 5 + (indexb + 1)
                                            ? selectedDay = 0
                                            : selectedDay =
                                                line * 5 + (indexb + 1);
                                        selectedDay == 0
                                            ? isBeforeExpanded = false
                                            : isBeforeExpanded = true;
                                      }),
                                      child: (selectedDay !=
                                              line * 5 + (indexb + 1)
                                          ? Container(
                                              width: 0.187 * width,
                                              height: 0.187 * width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Day ${line * 5 + (indexb + 1)}",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontSize:
                                                              0.037 * width,
                                                          fontFamily:
                                                              'GoogleSans')),
                                                  SizedBox(
                                                    height: 0.006 * height,
                                                  ),
                                                  Container(
                                                    width: 0.07 * width,
                                                    height: 0.07 * width,
                                                    decoration:
                                                        new BoxDecoration(
                                                      image:
                                                          new DecorationImage(
                                                        image: new AssetImage(
                                                            'assets/challengeCheck.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              width: 0.187 * width,
                                              height: 0.187 * width,
                                              decoration: new BoxDecoration(
                                                image: new DecorationImage(
                                                  image: new AssetImage(
                                                      'assets/selectedDay.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Day",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 0.037 * width,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'GoogleSans'),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "${line * 5 + (indexb + 1)}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 0.048 * width,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            'GoogleSans'),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            )),
                                    );
                                  }),
                                );
                              }),
                            )),
                        Container(
                          width: 0.94 * width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(fourList.length,
                                        (index) {
                                      return index < day % 5 - 1 || day % 5 == 0
                                          ? InkWell(
                                              onTap: () => setState(() {
                                                isTodayExpanded = false;
                                                selectedDay ==
                                                        ((day + 4) ~/ 5 - 1) *
                                                                5 +
                                                            index +
                                                            1
                                                    ? selectedDay = 0
                                                    : selectedDay =
                                                        ((day + 4) ~/ 5 - 1) *
                                                                5 +
                                                            index +
                                                            1;
                                                selectedDay == 0
                                                    ? isBeforeExpanded = false
                                                    : isBeforeExpanded = true;
                                              }),
                                              child: (selectedDay !=
                                                      ((day + 4) ~/ 5 - 1) * 5 +
                                                          index +
                                                          1
                                                  ? Container(
                                                      width: 0.187 * width,
                                                      height: 0.187 * width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Day ${((day + 4) ~/ 5 - 1) * 5 + index + 1}",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontSize:
                                                                      0.037 *
                                                                          width,
                                                                  fontFamily:
                                                                      'GoogleSans')),
                                                          SizedBox(
                                                            height:
                                                                0.006 * height,
                                                          ),
                                                          Container(
                                                            width: 0.07 * width,
                                                            height:
                                                                0.07 * width,
                                                            decoration:
                                                                new BoxDecoration(
                                                              image:
                                                                  new DecorationImage(
                                                                image: new AssetImage(
                                                                    'assets/challengeCheck.png'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 0.187 * width,
                                                      height: 0.187 * width,
                                                      decoration:
                                                          new BoxDecoration(
                                                        image:
                                                            new DecorationImage(
                                                          image: new AssetImage(
                                                              'assets/selectedDay.png'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Day",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    0.037 *
                                                                        width,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'GoogleSans'),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            "${((day + 4) ~/ 5 - 1) * 5 + index + 1}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    0.048 *
                                                                        width,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    'GoogleSans'),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                            )
                                          : Container();
                                    }) +
                                    [
                                      InkWell(
                                          onTap: () => setState(() {
                                                isBeforeExpanded = false;
                                                selectedDay = 0;
                                                isTodayExpanded =
                                                    !isTodayExpanded;
                                              }),
                                          child: (isTodayExpanded
                                              ? Container(
                                                  width: 0.187 * width,
                                                  height: 0.187 * width,
                                                  decoration: new BoxDecoration(
                                                    image: new DecorationImage(
                                                      image: new AssetImage(
                                                          'assets/selectedDay.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Day",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                0.037 * width,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'GoogleSans'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        "$day",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                0.048 * width,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'GoogleSans'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  width: 0.187 * width,
                                                  height: 0.187 * width,
                                                  decoration: new BoxDecoration(
                                                    image: new DecorationImage(
                                                      image: new AssetImage(
                                                          'assets/unSelectedToday.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Day",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff42B261),
                                                            fontSize:
                                                                0.037 * width,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'GoogleSans'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      Text(
                                                        "$day",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff42B261),
                                                            fontSize:
                                                                0.048 * width,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'GoogleSans'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ))),
                                    ] +
                                    List.generate(fourList.length, (index) {
                                      return index >= day % 5 - 1 &&
                                              day % 5 != 0
                                          ? Container(
                                              width: 0.187 * width,
                                              height: 0.187 * width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Day ${day ~/ 5 * 5 + index + 2}",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontSize:
                                                              0.037 * width,
                                                          fontFamily:
                                                              'GoogleSans')),
                                                  SizedBox(
                                                    height: 0.006 * height,
                                                  ),
                                                  Container(
                                                    width: 0.08 * width,
                                                    height: 0.08 * width,
                                                    decoration:
                                                        new BoxDecoration(
                                                      image:
                                                          new DecorationImage(
                                                        image: new AssetImage(
                                                            'assets/challengeLocked.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container();
                                    }),
                              ),
                            ],
                          ),
                        ),
                        ExpandedSection(
                          expand: isBeforeExpanded,
                          child: BeforeChallWidget(challengeState: this),
                        ),
                        ExpandedSection(
                          expand: isTodayExpanded,
                          child: ChallengeWidget(
                            challengeState: this,
                          ),
                        ),
                        Container(
                          width: 0.94 * width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  fiveList.length,
                                  (index) {
                                    return Container(
                                      width: 0.187 * width,
                                      height: 0.187 * width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Day ${((day + 4) ~/ 5) * 5 + index + 1}",
                                              style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontSize: 0.037 * width,
                                                  fontFamily: 'GoogleSans')),
                                          SizedBox(
                                            height: 0.006 * height,
                                          ),
                                          Container(
                                            width: 0.08 * width,
                                            height: 0.08 * width,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: new AssetImage(
                                                    'assets/challengeLocked.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
