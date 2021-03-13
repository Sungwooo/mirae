import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        text,
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

class ArticleDetailPage extends StatelessWidget {
  final Arguments arguments;

  ArticleDetailPage({Key key, @required this.arguments}) : super(key: key);
  final List<Color> _colors = [
    Color(0xff88C81F).withOpacity(0.9),
    Color(0xff36AE57).withOpacity(0.9),
  ];
  final List<double> _stops = [0, 1];

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
          Padding(
            padding: EdgeInsets.only(
                left: 0.04 * width, right: 0.04 * width, top: 0.028 * height),
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
          Padding(
            padding: EdgeInsets.only(
                top: 0.02 * height, left: 0.04 * width, right: 0.04 * width),
            child: Container(
              width: 342,
              child: Text(
                  arguments.title,
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GoogleSans')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 2, left: 0.034 * width, right: 0.034 * width),
            child: Container(
              width: 0.934 * width,
              height: 0.195 * height,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: new DecorationImage(
                  image: new NetworkImage(
                    arguments.image
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, left: 0.032 * width),
            child: Container(
              child: Text(arguments.writer,
                  style: TextStyle(
                      color: Color(0xff8A8A8A),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GoogleSans')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 13, top: 12),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: _colors,
                    stops: _stops,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.024 * width,
                  horizontal: 0.023 * height,
                ),
                child: Text(
                    arguments.attract,
                    style: TextStyle(
                        color: Color(0xffF8F8F8),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GoogleSans')),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 0.019 * height, left: 0.05 * width, right: 0.05 * width),
            child: Container(
              width: 0.896 * width,
              child: Text(
                  'The US, under the Trump administration, withdrew from the landmark treaty to curb global warming but President Joseph Biden reversed the decision when he assumed office in January. \n\n“For the past four years, the absence of a key player created a gap in the Paris Agreement; a missing link that weakened the whole”, Mr. Guterres said.\n\n“So today, as we mark the United States re-entry into this treaty, we also recognize its restoration, in its entirety, as its creators intended. Welcome back.” \n\n‘Humility and ambition’ \n\n Describing the occasion as “a day of hope”, the Secretary-General said he was particularly pleased to be commemorating the event with John Kerry, the US Special Presidential Envoy for Climate.\n\nThe veteran politician and diplomat was Secretary of State when the US, alongside 194 other countries, adopted the Paris Agreement in December 2015.  He was at the UN the following April to sign the treaty, accompanied by his granddaughter.\n\n“We rejoin the international climate effort with humility and with ambition”, said Mr. Kerry.\n\n“Humility knowing that we lost four years during which America was absent from the table, and humility in knowing that today, no country and no continent is getting the job done. But also with ambition, knowing that Paris alone will not do what science tells us we must do together”. A ‘pivotal’ year for action The Paris Agreement aims to limit global temperature rise to 1.5 Celsius above pre-industrial levels by curbing greenhouse gas emissions. It requires countries to commit to increasingly ambitious climate action through plans known as Nationally Determined Contributions (NDCs). ',
                  style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GoogleSans')),
            ),
          ),
        ]));
  }
}
