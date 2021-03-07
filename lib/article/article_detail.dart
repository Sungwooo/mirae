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
  final List<Color> _colors = [
    Color(0xff88C81F).withOpacity(0.9),
    Color(0xff36AE57).withOpacity(0.9),
  ];
  final List<double> _stops = [0, 1];

  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(left: 16, right: 17, top: 23),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        width: 3,
                        height: 14,
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
            padding: const EdgeInsets.only(top: 17, left: 16, right: 16),
            child: Container(
              width: 342,
              child: Text(
                  'UN hails ‘day of hope’ as US officially rejoins Paris climate accord',
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GoogleSans')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 12, right: 13),
            child: Container(
              width: 350,
              height: 158.63,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: new DecorationImage(
                  image: new NetworkImage(
                    "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/19-02-2021_UNOCHA_Climate_Change_Crisis-01.jpg/image350x235cropped.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.37, left: 12),
            child: Container(
              child: Text('Unsplash/Matthew T. Rader',
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
                padding: const EdgeInsets.only(
                    top: 9.0, left: 19, right: 18, bottom: 8),
                child: Text(
                    'The official return of the United States to the Paris Agreement on Climate Change represents good news for the country and the world, UN Secretary-General António Guterres said on Friday during a virtual event to mark the occasion. ',
                    style: TextStyle(
                        color: Color(0xffF8F8F8),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GoogleSans')),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 19, right: 20),
            child: Container(
              width: 336,
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
