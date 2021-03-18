import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../mainPage/mainPage.dart';

final List<int> carouselList = [0, 1];

class TrashInfoPaper extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String imagePath;

  TrashInfoPaper(this.cameras, this.imagePath);

  @override
  _TrashInfoPaperState createState() => _TrashInfoPaperState();
}

class _TrashInfoPaperState extends State<TrashInfoPaper> {
  int _currentCarousel = 0;

  Widget _renderRecycleButton() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: FlatButton(
        onPressed: () => {},
        color: Color.fromRGBO(72, 167, 255, 0.8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/ic_recycle_white.png', width: 20, height: 20),
            Text("Recyclables",
                style: TextStyle(
                    fontSize: 0.042 * width,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  String getTrueTitle(int type) {
    if (type == 1) {
      return "Recycling 1 ton of paper";
    }

    return "How is it recycled?";
  }

  Widget _renderHandlinedTitle(int type) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: 260,
      child: Column(
        children: [
          Text(getTrueTitle(type),
              style: TextStyle(
                  fontSize: 0.058 * width,
                  color: Colors.black,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w600)),
          Image.asset('assets/handline_green.png', height: 10),
        ],
      ),
    );
  }

  Widget _renderHandleContainer0() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            _renderHandlinedTitle(_currentCarousel),
            SizedBox(height: 20),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                      "Involves mixing used/old paper with water and chemicals to break it down",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.045 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                      "Chopped up and heated, which breaks it down further into strands of cellulose",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.045 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                      "Remove any remaining plastic and ink from the mixture",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.045 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w500)),
                )),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("Then it can be made into new paper",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.045 * width,
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
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.only(top: 14, left: 2, right: 2),
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
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            _renderHandlinedTitle(_currentCarousel),
            Text("save up",
                style: TextStyle(
                    fontSize: 0.04 * width,
                    color: Colors.black,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("17 trees born in 30 years old",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.053 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                )),
              ],
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("4,200kW of electricity",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.053 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                )),
              ],
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("1,500ℓ of oil",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.053 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                )),
              ],
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("28 tons of water",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 0.053 * width,
                          color: Colors.black,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselList.map((i) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.only(top: 32, left: 2, right: 2),
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
          height: 360,
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
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 24),
        child: SizedBox(
            width: double.infinity,
            child: FlatButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(widget.cameras)),
              ),
              color: Color.fromRGBO(54, 174, 87, 0.9),
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("+ 40 poinsts",
                      style: TextStyle(
                          fontSize: 0.064 * width,
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                  Image.asset('assets/handline_white.png',
                      width: double.infinity, height: 10)
                ],
              ),
            )));
  }

  Widget _renderContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text('PAPER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 0.085 * width,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600)),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(File(widget.imagePath),
                width: 150.0, height: 150.0, fit: BoxFit.cover),
          ),
          _renderRecycleButton(),
          _renderHandleCarousel(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('You saved the world 10 years',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 0.053 * width,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600)),
          ),
          _renderPointButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text('PING',
                style: TextStyle(
                    color: Color.fromRGBO(49, 172, 131, 1),
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600)),
            centerTitle: true),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage('assets/bg_can.png'),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: _renderContent()),
          ),
        ));
  }
}
