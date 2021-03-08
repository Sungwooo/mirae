import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/home/components/before_chall_widget.dart';
import 'package:mirae/home/components/today_chall_widget.dart';
import 'package:mirae/home/components/expand_section.dart';

class Challenge extends StatefulWidget {
  @override
  ChallengeState createState() => ChallengeState();
}

class ChallengeState extends State<Challenge> {
  bool isBeforeExpanded = false;
  bool isTodayExpanded = false;
  int selectedDay = 0;
  int day = 5;
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                              fontWeight: FontWeight.w700,
                              fontFamily: 'GoogleSans'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11, bottom: 8),
                          child: Text(
                            "Today you can burn",
                            style: TextStyle(
                                color: Color(0xffFCE490),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/running.png',
                                  height: 28,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 11),
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                            color: Color(0xffFF8A00),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            fontFamily: 'GoogleSans'),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    "calories",
                                    style: TextStyle(
                                        color: Color(0xffFF8A00),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
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
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Container(
                width: 350,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(fourList.length, (index) {
                            return InkWell(
                              onTap: () => setState(() {
                                isTodayExpanded = false;
                                selectedDay == index + 1
                                    ? selectedDay = 0
                                    : selectedDay = index + 1;
                                selectedDay == 0
                                    ? isBeforeExpanded = false
                                    : isBeforeExpanded = true;
                              }),
                              child: (selectedDay != index + 1
                                  ? Container(
                                      width: 70,
                                      height: 70,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      ),
                                    )
                                  : Container(
                                      width: 70,
                                      height: 70,
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
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GoogleSans'),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GoogleSans'),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )),
                            );
                          }) +
                          [
                            InkWell(
                                onTap: () => setState(() {
                                      isBeforeExpanded = false;
                                      selectedDay = 0;
                                      isTodayExpanded = !isTodayExpanded;
                                    }),
                                child: (isTodayExpanded
                                    ? Container(
                                        width: 70,
                                        height: 70,
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
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'GoogleSans'),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "$day",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'GoogleSans'),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 70,
                                        height: 70,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/unSelectedToday.png'),
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
                                                  color: Color(0xff42B261),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'GoogleSans'),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "$day",
                                              style: TextStyle(
                                                  color: Color(0xff42B261),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'GoogleSans'),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ))),
                          ],
                    ),
                  ],
                ),
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
              width: 350,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      fiveList.length,
                      (index) {
                        return Container(
                          width: 70,
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Day ${day + index + 1}",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'GoogleSans')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 30,
                                height: 30,
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
        ));
  }
}
