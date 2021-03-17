import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mirae/components/text_underline.dart';
import 'package:mirae/home/challenge.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/map/map.dart';
import 'package:provider/provider.dart';

var now = DateFormat('y.MM.dd').format(DateTime.now());

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'GoogleSans',
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GradientText1 extends StatelessWidget {
  GradientText1(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'GoogleSans',
            // The color must be set to white for this to work
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  FirebaseProvider fp;
  int challengeDay = 1;
  var isCheck1 = false;
  var isCheck2 = false;
  var isCheck3 = false;

  final List<Color> _colors = [
    Color(0xffF4C623).withOpacity(0.8),
    Color(0xffF4C623).withOpacity(0.712),
    Color(0xffF4C623).withOpacity(0)
  ];
  final List<double> _stops = [0, 0.5312, 1];

  final List<String> entries = <String>[
    '1',
    '2',
    '3',
  ]; //rest api < 뉴스 5개 크롤링?

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    challengeDay = fp != null
        ? DateTime.now().difference(fp.getUser().metadata.creationTime).inDays +
            2
        : 5;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CupertinoNavigationBar(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.0, // One physical pixel.
              style: BorderStyle.none,
            ),
          ),
          middle: Text(
            "HOME",
            style:
                TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
          ),
        ),
        body: ListView(
          //shrinkWrap: true,
          //crossAxisCount: 1,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 0.027 * width,
                  top: 0.019 * height,
                  right: 0.057 * width,
                  bottom: 0.013 * height),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GradientText(
                      'Day $challengeDay',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff36AE57),
                          Color(0xff229DE2),
                        ],
                      ),
                    ),
                    Text(now,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xff36AE57),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GoogleSans'))
                  ]),
            ),

            //SizedBox(height:20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => Challenge());
                },
                child: Container(
                  width: 0.93 * width,
                  height: 0.29 * height,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff36AE57).withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
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
                                      isCheck1 = !isCheck1;
                                    }),
                                    child: isCheck1
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
                                      isCheck2 = !isCheck2;
                                    }),
                                    child: isCheck2
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
                                      isCheck3 = !isCheck3;
                                    }),
                                    child: isCheck3
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: 0.025 * height),
              child: InkWell(
                onTap: () => Get.to(() => MapPage()),
                child: Container(
                  height: 0.1 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage("assets/homePingBg.png"),
                        fit: BoxFit.fill),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffA79F84),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.014 * height, left: 0.043 * width),
                            child: Text(
                              'There are 5 pings nearby',
                              style: TextStyle(
                                  color: Color(0xff343434),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'GoogleSans'),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 1.0, left: 0.043 * width),
                            child: Container(
                              width: 0.616 * width,
                              height: 0.009 * height,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage('assets/underline.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.006 * height, left: 0.054 * width),
                            child: Text(
                                'Burn calories and save the environment',
                                style: TextStyle(
                                    color: Color(0xff31AC53),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'GoogleSans')),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.054 * width,
                          ),
                          child: Image.asset(
                            'assets/ping.png',
                            width: 0.14 * width,
                          ),
                        ),
                        Text('5',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                      ]),
                ),
              ),
            ),
            Container(
                height: 0.303 * height,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 0.032 * width,
                          bottom: 0.01 * height,
                          top: 0.005 * height),
                      child: InkWell(
                        child: Container(
                          height: 0.283 * height,
                          width: 0.504 * width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/homeTab${entries[index]}.png'),
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                color: entries[index] == '1'
                                    ? Color(0xff4DA8FC)
                                    : entries[index] == '2'
                                        ? Color(0xffB6730F)
                                        : Color(0xff08BD61),
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        onTap: null,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                )),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
