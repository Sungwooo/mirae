import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/article/article_detail.dart';

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
            fontSize: 30,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  Widget build(BuildContext context) {
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
            "NEWS",
            style:
                TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
          ),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.034 * width, vertical: 0.02 * height),
            child: Container(
                height: 0.08 * height,
                decoration: BoxDecoration(
                  color: Color(0xff36AE57).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(54, 174, 87, 0.7),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/world.png',
                              width: 0.1 * width,
                            ),
                            SizedBox(
                              width: 0.04 * width,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text('E - Challenges',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'GoogleSans')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/check.png',
                                          width: 0.037 * width,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.013 * width),
                                          child: Text('2',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'GoogleSans')),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Day 1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'GoogleSans')),
                              Image.asset(
                                "assets/underline.png",
                                width: 0.184 * width,
                                height: 0.007 * height,
                                fit: BoxFit.fill,
                              ),
                            ]),
                      ]),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 0.032 * width,
                right: 0.04 * width,
                bottom: 0.007 * height),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GradientText(
                    'Eco news',
                    gradient: LinearGradient(colors: [
                      Color(0xff229DE2),
                      Color(0xff2EC9C0),
                    ]),
                  ),
                  Text('2021.02.22',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(0xff4B4B4B),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GoogleSans'))
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.032 * width),
            child: GestureDetector(
              onTap: () {
                Get.to(() => ArticleDetailPage());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(
                      width: 0.934 * width,
                      height: 0.295 * height,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(
                            "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/19-02-2021_UNOCHA_Climate_Change_Crisis-01.jpg/image350x235cropped.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        // boxShadow
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        width: 0.934 * width,
                        height: 0.295 * height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomLeft,
                                end: FractionalOffset.topRight,
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0)
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ])),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0.04 * width, bottom: 0.01 * height),
                                child: Container(
                                    width: 0.853 * width,
                                    child: Text(
                                      'FROM THE FIELD: Poor and vulnerable bear brunt of climate change',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'GoogleSans'),
                                    )),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.024 * height, left: 0.032 * width),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 0.408 * width,
                    height: 0.127 * height,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: new DecorationImage(
                        image: new NetworkImage(
                          "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/25-02-2021_UNDP_Ghana-02.jpg/image350x235cropped.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.034 * width),
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                width: 0.49 * width,
                                child: Text(
                                    'FROM THE FIELD: Adapting to survive and thrive in Ghana',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'GoogleSans')),
                              )
                            ]),
                            Padding(
                              padding: EdgeInsets.only(top: 0.005 * height),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 0.01 * width),
                                  child: Container(
                                    width: 0.008 * width,
                                    height: 0.017 * height,
                                    color: Color(0xffF4BB27),
                                  ),
                                ),
                                Text('Africa',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'GoogleSans')),
                              ]),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.024 * height, left: 0.032 * width),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 0.408 * width,
                    height: 0.127 * height,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: new DecorationImage(
                        image: new NetworkImage(
                          "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/16-01-2020-ZIM_20191203_WFP-Matteo_Cosorich_9596.jpg/image350x235cropped.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.034 * width),
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                width: 0.49 * width,
                                child: Text(
                                    'UN climate report a ‘red alert’ for the planet: Guterres',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'GoogleSans')),
                              )
                            ]),
                            Padding(
                              padding: EdgeInsets.only(top: 0.005 * height),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 0.01 * width),
                                  child: Container(
                                    width: 0.008 * width,
                                    height: 0.017 * height,
                                    color: Color(0xffF4BB27),
                                  ),
                                ),
                                Text('Global',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'GoogleSans')),
                              ]),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
