import 'dart:ui';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';

import 'package:loading/loading.dart';
import 'package:mirae/article/argument.dart';
import 'package:mirae/article/article_detail.dart';
import 'package:mirae/home/challenge.dart';
import 'package:mirae/home/controller/challenge_controller.dart';

import 'package:mirae/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';

var now = DateFormat('y.MM.dd').format(DateTime.now());

class ResultItem extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final String attract;
  final String writer;
  final String image;
  final String url;

  const ResultItem(
      {Key key,
      this.writer,
      this.title,
      this.date,
      this.category,
      this.attract,
      this.url,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Arguments data =
        Arguments(title, date, category, attract, writer, image, url);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(arguments: data),
              ),
            );
          },
          child: Container(
            width: 0.934 * width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.408 * width,
                  height: 0.127 * height,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(
                      image: new NetworkImage(
                        image,
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
                                  title.length > 80
                                      ? title.substring(0, 80) + "..."
                                      : title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 0.042 * width,
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
                              Text(category != '' ? category : 'Video',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff239EDD),
                                      fontSize: 0.032 * width,
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
        ));
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            fontSize: 0.08 * width,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ArticlePage extends StatefulWidget {
  final String search;

  const ArticlePage({Key key, this.search}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<ArticlePage> {
  bool loaded = false;
  // ignore: deprecated_member_use
  List<ResultItem> resultList = List();
  FirebaseProvider fp;
  final ChallengeController challengeController =
      Get.put(ChallengeController());

  @override
  void initState() {
    super.initState();
    initChaptersTitleScrap();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void initChaptersTitleScrap() async {
    final rawUrl = 'https://news.un.org/en/news/topic/climate-change';
    final webScraper = WebScraper('https://news.un.org/');
    final endpoint = rawUrl.replaceAll(r'https://news.un.org/', '');
    if (await webScraper.loadWebPage(endpoint)) {
      List<Map<String, dynamic>> writers = webScraper
          .getElement('div.field-name-field-scald-photo-credit ', ['']);
      List<Map<String, dynamic>> titles = webScraper.getElement(
          'div.view-content > div.views-row > div.body-wrapper > h1.story-title ',
          []);
      List<Map<String, dynamic>> dates = webScraper.getElement(
          'div.view-content > div.views-row > div.body-wrapper > div.wrapper-date >  div.story-date ',
          []);
      List<Map<String, dynamic>> categories =
          webScraper.getElement('div.topics', ['']);
      List<Map<String, dynamic>> attracts = webScraper.getElement(
          'div.view-content > div.views-row > div.body-wrapper > div.news-body ',
          []);
      List<Map<String, dynamic>> images =
          webScraper.getElement('img.img-responsive', ['src']);
      List<Map<String, dynamic>> urls =
          webScraper.getElement('h1.story-title > a', ['href']);

      titles.forEach((title) {
        int i = titles.indexOf(title);
        resultList.add(
          ResultItem(
            title: titles[i]['title'],
            date: dates[i]['title'],
            category: categories[i]['title'] ?? 'video',
            attract: attracts[i]['title'],
            writer: writers[i]['title'],
            url: urls[i]['attributes']['href'],
            image: images[i + 1]['attributes']['src'],
          ),
        );
      });
      setState(() {
        loaded = true;
      });
    }
  }

  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
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
            child: InkWell(
              onTap: () =>
                  Get.to(() => Challenge()).then((value) => setState(() {})),
              child: Container(
                  height: 0.08 * height,
                  decoration: BoxDecoration(
                    color: Color(0xff36AE57).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff36AE57).withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
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
                                            fontSize: 0.048 * width,
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
                                            child: Text(
                                                '${challengeController.checksNum}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 0.037 * width,
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
                                Text(
                                    'Day ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(fp.getUser().metadata.creationTime).inDays + 1}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 0.069 * width,
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.034 * width),
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
                  Column(
                    children: [
                      Text(now,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color(0xff4B4B4B),
                              fontSize: 0.037 * width,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'GoogleSans')),
                      SizedBox(
                        height: 0.006 * height,
                      ),
                    ],
                  )
                ]),
          ),
          /*Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.032 * width),
            child:
          ),*/

          Padding(
            padding: EdgeInsets.only(top: 0.01 * height),
            child: (loaded)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                    arguments: Arguments(
                                        resultList[0].title,
                                        resultList[0].date,
                                        resultList[0].category,
                                        resultList[0].attract,
                                        resultList[0].writer,
                                        resultList[0].image,
                                        resultList[0].url)),
                              ),
                            );
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
                                        resultList[0].image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    // boxShadow
                                  ),
                                ),
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 1, sigmaY: 1),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.04 * width,
                                                bottom: 0.01 * height),
                                            child: Container(
                                                width: 0.853 * width,
                                                child: Text(
                                                  resultList[0].title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 0.064 * width,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                        ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: resultList.getRange(1, 10).toList(),
                        )
                      ])
                : Container(
                    height: height * 0.6,
                    child: Center(
                      child: Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          child: Loading(
                              indicator: BallBeatIndicator(),
                              size: 0.15 * width,
                              color: Color(0xff36A257))),
                    ),
                  ),
          ),
          SizedBox(
            height: height * 0.05,
          )
        ]));
  }
}
