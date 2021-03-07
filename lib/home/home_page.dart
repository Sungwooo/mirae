import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/components/text_underline.dart';
import 'package:mirae/home/challenge.dart';

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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isCheck1 = false;
  var _isCheck2 = false;
  var _isCheck3 = false;

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
    '4',
    '5'
  ]; //rest api < 뉴스 5개 크롤링?

  @override
  Widget build(BuildContext context) {
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
                      'Day 1',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff36AE57),
                          Color(0xff229DE2),
                        ],
                      ),
                    ),
                    Text('2021.02.22',
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
              padding: const EdgeInsets.symmetric(horizontal: 13),
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
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/world.png',
                                width: 30,
                              ),
                              SizedBox(
                                width: 15,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.asset(
                                  'assets/circle1.png',
                                  width: 25,
                                ),
                                Container(
                                    width: 221,
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
                                            width: 42,
                                            height: 39,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/homeChecked.png",
                                                  width: 26,
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
                                            width: 42,
                                            height: 39,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/homeUnChecked.png",
                                                width: 26,
                                              ),
                                            ),
                                          ),
                                  ),
                                ]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.asset(
                                  'assets/circle2.png',
                                  width: 25,
                                ),
                                Container(
                                    width: 221,
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
                                            width: 42,
                                            height: 39,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/homeChecked.png",
                                                  width: 26,
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
                                            width: 42,
                                            height: 39,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/homeUnChecked.png",
                                                width: 26,
                                              ),
                                            ),
                                          ),
                                  ),
                                ]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.asset(
                                  'assets/circle3.png',
                                  width: 25,
                                ),
                                Container(
                                  width: 221,
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
                                            width: 42,
                                            height: 39,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/homeChecked.png",
                                                  width: 26,
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
                                            width: 42,
                                            height: 39,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/homeUnChecked.png",
                                                width: 26,
                                              ),
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
                          padding: const EdgeInsets.only(top: 12.0, left: 16.0),
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
                          padding: const EdgeInsets.only(top: 1.0, left: 16.0),
                          child: Container(
                            width: 231,
                            height: 7,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('assets/underline.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                          child: Text('Burn calories and save the environment',
                              style: TextStyle(
                                  color: Color(0xff31AC53),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'GoogleSans')),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Image.asset(
                          'assets/ping.png',
                          width: 50,
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
            Container(
                child: SizedBox(
                    height: 106,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            color: Colors.grey,
                            width: 106,
                            height: 106,
                            child: Text('${entries[index]}번 뉴스',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'GoogleSans')),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )))
          ],
        ));
  }
}
