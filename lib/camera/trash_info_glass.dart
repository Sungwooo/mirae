import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/camera/discard_splash.dart';
import '../mainPage/mainPage.dart';

final List<int> carouselList = [0, 1];

class TrashInfoGlass extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String imagePath;

  TrashInfoGlass(this.cameras, this.imagePath);

  @override
  _TrashInfoGlassState createState() => _TrashInfoGlassState();
}

class _TrashInfoGlassState extends State<TrashInfoGlass> {
  int _currentCarousel = 0;

  Widget _renderRecycleButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.256 * width),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 0.1 * width,
          color: Color.fromRGBO(72, 167, 255, 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/ic_recycle_white.png',
                  width: 0.064 * width, height: 0.064 * width),
              Text("Recyclables",
                  style: TextStyle(
                      fontSize: 0.048 * width,
                      color: Colors.white,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ),
    );
  }

  String getTrueTitle(int type) {
    if (type == 1) {
      return "Recycling glass";
    }

    return "How is it recycled?";
  }

  Widget _renderHandlinedTitle(int type) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: 0.693 * width,
      child: Column(
        children: [
          Text(getTrueTitle(type),
              style: TextStyle(
                  fontSize: 0.053 * width,
                  color: Colors.black,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w600)),
          Image.asset(
            'assets/handline_green.png',
            width: getTrueTitle(type).length * 0.03 * width,
            height: 0.01 * width,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget _renderHandleContainer0() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 0.053 * width, vertical: 0.014 * height),
        margin: EdgeInsets.symmetric(horizontal: 0.045 * width),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _renderHandlinedTitle(_currentCarousel),
            Row(
              children: [
                Image.asset(
                  'assets/ic_number_1.png',
                  width: 0.08 * width,
                  height: 0.08 * width,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text("Crushed and contaminants removed",
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_2.png',
                    width: 0.08 * width, height: 0.08 * width),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text(
                      "Mixed with the raw materials to colour and/or enhance properties as necessary",
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_3.png',
                    width: 0.08 * width, height: 0.08 * width),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text("Melted in a furnace",
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_4.png',
                    width: 0.08 * width, height: 0.08 * width),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text("Moulded or blown into new bottles or jars.",
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselList.map((i) {
                return Container(
                  width: 0.021 * width,
                  height: 0.021 * width,
                  margin: EdgeInsets.symmetric(horizontal: 0.006 * width),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarousel == i
                        ? Color.fromRGBO(57, 169, 84, 1)
                        : Color.fromRGBO(192, 192, 192, 1),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }

  Widget _renderHandleContainer1() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 0.053 * width, vertical: 0.014 * height),
        margin: EdgeInsets.symmetric(horizontal: 0.045 * width),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _renderHandlinedTitle(_currentCarousel),
                SizedBox(
                  height: 0.026 * width,
                ),
                Text(
                  "Glass is 100% recyclable and can be endlessly recycled with no loss of quality.",
                  style: TextStyle(
                      fontSize: 0.037 * width,
                      color: Colors.black,
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_number_1.png',
                  width: 0.08 * width,
                  height: 0.08 * width,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text("Reduce non-renewable fossil fuel usage",
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/ic_number_2.png',
                    width: 0.08 * width, height: 0.08 * width),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 0.032 * width),
                  child: Text(
                      "Reduce the emissions of process CO2 from the carbonate raw materials such as limestone",
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 0.042 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselList.map((i) {
                return Container(
                  width: 0.021 * width,
                  height: 0.021 * width,
                  margin: EdgeInsets.symmetric(horizontal: 0.006 * width),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarousel == i
                        ? Color.fromRGBO(57, 169, 84, 1)
                        : Color.fromRGBO(192, 192, 192, 1),
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }

  Widget _renderHandleCarousel() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> carouselComponentList = [
      _renderHandleContainer0(),
      _renderHandleContainer1(),
    ];

    return CarouselSlider(
      items: carouselComponentList,
      options: CarouselOptions(
          height: 0.8 * width,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              _currentCarousel = index;
            });
          }),
    );
  }

  Widget _renderPointButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.045 * width),
        child: SizedBox(
            width: double.infinity,
            child: FlatButton(
              onPressed: () => Get.to(() => DiscardSplash()),
              color: Color.fromRGBO(54, 174, 87, 0.9),
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("+ 40 points",
                      style: TextStyle(
                          fontSize: 0.058 * width,
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w700)),
                  Image.asset(
                    'assets/handline_white.png',
                    width: 0.309 * width,
                    height: 0.016 * width,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            )));
  }

  Widget _renderContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('GLASS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 0.085 * width,
                color: Colors.white,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.w600)),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Color(0xff3CAE5B),
            width: 0.4 * width,
            height: 0.4 * width,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(widget.imagePath),
                    width: 0.4 * width - 4,
                    height: 0.4 * width - 4,
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        _renderRecycleButton(),
        Column(
          children: [
            _renderHandleCarousel(),
            Padding(
                padding: EdgeInsets.only(top: 0.01 * width),
                child: Container(
                  width: width * 0.9,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                        text: "source from ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 0.032 * width,
                        ),
                        children: [
                          TextSpan(
                            text: "recyclenow.com",
                            style: TextStyle(
                                color: Color(0xff67FF92),
                                fontWeight: FontWeight.w700,
                                fontSize: 0.032 * width),
                          )
                        ]),
                  ),
                )),
          ],
        ),
        _renderPointButton(),
      ],
    );
  }

  @override
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
            "TRASH",
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
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage('assets/bg_glass.png'),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: _renderContent()),
          ),
        ));
  }
}
