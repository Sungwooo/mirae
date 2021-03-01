import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 42,
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
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 30,
        ),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CupertinoNavigationBar(
        middle: Text(
          "HOME",
          style: TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
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
        //shrinkWrap: true,
        //crossAxisCount: 1,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 16.0, right: 22.0, bottom: 10.38),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GradientText(
                    'Day 1',
                    gradient: LinearGradient(colors: [
                      Color(0xff229DE2),
                      Color(0xff36AE57),
                    ]),
                  ),
                  Text('2021.02.22',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xff36AE57), fontSize: 16))
                ]),
          ),
          //SizedBox(height:20),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 13.0, bottom: 0.0),
            child: Container(
              width: 350,
              height: 266,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, offset: Offset(3, 3)),
                  BoxShadow(
                      color: Colors.grey.shade200, offset: Offset(-3, -3)),
                ],
                color: Color(0xff36AE57),
                borderRadius: BorderRadius.circular(10),
                // boxShadow
              ),
              child: Column(
                children: [
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 82.0, top: 11.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage('assets/world.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 14.0),
                      child: Text('E - Challenge',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 13.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 25,
                          height: 25,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage('assets/circle1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Text('Using a tumbler',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(children: [
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
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 13.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 25,
                          height: 25,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage('assets/circle2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Text(
                              'Donating items you don\n' 't use at home',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(children: [
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
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 13.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 25,
                          height: 25,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage('assets/circle3.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: Text('Using public transportation',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(children: [
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 12, right: 12),
            child: Container(
              height: 76,
              width: 350,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200, offset: Offset(3, 3)),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: _colors,
                    stops: _stops,
                  )),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                    child: Text('There are 5 pings nearby',
                        style:
                            TextStyle(color: Color(0xff343434), fontSize: 20)),
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
                        style:
                            TextStyle(color: Color(0xff31AC53), fontSize: 12)),
                  ),
                ]),
                SizedBox(width: 10),
                Container(
                  width: 26.93,
                  height: 26.93,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/ping.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('5',
                    style: TextStyle(color: Color(0xff000000), fontSize: 20)),
              ]),
            ),
          ),
          //SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 30.0, bottom: 11.0),
            child: GradientText1(
              'NEWS Highlights',
              gradient: LinearGradient(colors: [
                Color(0xff229DE2),
                Color(0xff2EC9C0),
              ]),
            ),
          ),
          Container(
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
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ))
        ],
      ),
    );
  }
}
