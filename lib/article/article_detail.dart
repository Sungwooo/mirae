import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_scraper/web_scraper.dart';

import 'argument.dart';

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
        text.trim(),
        style: TextStyle(
          fontFamily: 'GoogleSans',
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ArticleDetailPage extends StatelessWidget {
  // ignore: deprecated_member_use

  final Arguments arguments;

  ArticleDetailPage({Key key, @required this.arguments}) : super(key: key);

  final List<Color> _colors = [
    Color(0xff88C81F).withOpacity(0.9),
    Color(0xff36AE57).withOpacity(0.9),
  ];
  final List<double> _stops = [0, 1];

  // ignore: missing_return
  Future<List> initChaptersTitleScrap() async {
    List resultList = [];
    final rawUrl = arguments.url;
    print(arguments.url);
    final webScraper = WebScraper('https://news.un.org/');
    if (await webScraper.loadWebPage(rawUrl)) {
      List<Map<String, dynamic>> articles =
          webScraper.getElement('div.field-item.even > p, h3', []);
      print(articles);
      articles.forEach((article) {
        int i = articles.indexOf(article);
        resultList.add(articles[i]['title']);
      });
      resultList.removeRange(0, 2);
      return resultList;
    }
  }

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
            style: TextStyle(
                color: Color(0xff31AC53),
                fontWeight: FontWeight.w700,
                fontFamily: 'GoogleSans'),
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
        body: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.028 * height),
                child: Container(
                  width: 0.936 * width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.only(right: 0.01 * width),
                            child: Container(
                              width: 0.008 * width,
                              height: 0.017 * height,
                              color: Color(0xffF4BB27),
                            ),
                          ),
                          Text(arguments.category,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'GoogleSans')),
                        ]),
                        Text(arguments.date,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xff4B4B4B),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GoogleSans'))
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 0.02 * height,
                ),
                child: Container(
                  width: 0.936 * width,
                  child: Text(arguments.title,
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GoogleSans')),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Container(
                  width: 0.934 * width,
                  height: 0.195 * height,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(
                      image: new NetworkImage(arguments.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2, left: 0.032 * width),
                child: Container(
                  width: 0.968 * width,
                  child: Text(arguments.writer,
                      style: TextStyle(
                          color: Color(0xff8A8A8A),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GoogleSans')),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.014 * height),
                child: Container(
                  width: 0.936 * width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: _colors,
                        stops: _stops,
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.011 * height,
                      horizontal: 0.05 * width,
                    ),
                    child: Text(arguments.attract.trim(),
                        style: TextStyle(
                            color: Color(0xffF8F8F8),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'GoogleSans')),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: initChaptersTitleScrap(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 0.019 * height,
                        left: 0.032 * width,
                        right: 0.032 * width),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Container(
                              width: 0.936 * width,
                              child: Text(snapshot.data[index],
                                  style: TextStyle(
                                      color: Color(0xff363636),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'GoogleSans')),
                            ),
                          );
                        }),
                  );
                }
              }),
        ]));
  }
}
