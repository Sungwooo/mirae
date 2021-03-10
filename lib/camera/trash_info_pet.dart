import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../mainPage/mainPage.dart';

class TrashInfoPet extends StatefulWidget {
  final List<CameraDescription> cameras;
  TrashInfoPet(this.cameras);

  @override
  _TrashInfoPetState createState() => _TrashInfoPetState();
}

class _TrashInfoPetState extends State<TrashInfoPet> {
  Widget _renderRecycleButton() {
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
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  Widget _renderHandlinedTitle() {
    return Container(
      width: 250,
      child: Column(
        children: [
          Text("How to handle",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w600)),
          Image.asset('assets/handline_green.png', height: 10),
        ],
      ),
    );
  }

  Widget _renderHandleContainer() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            _renderHandlinedTitle(),
            SizedBox(height: 30),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
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
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
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
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
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
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontFamily: 'GoogleSans',
                              fontWeight: FontWeight.w500)),
                    )),
              ],
            ),
            SizedBox(height: 24),
          ],
        ));
  }

  Widget _renderPointButton() {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: () => {},
          color: Color.fromRGBO(54, 174, 87, 0.9),
          padding: EdgeInsets.all(10.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage(widget.cameras)),
              ),
              child: Column(
                children: [
                  Text("+ 40 poinsts",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.w600)),
                  Image.asset('assets/handline_white.png',
                      width: double.infinity, height: 10)
                ],
              )),
        ));
  }

  Widget _renderContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text('CAN',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600)),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'assets/trash_paper.png',
              width: 150.0,
              height: 150.0,
            ),
          ),
          _renderRecycleButton(),
          _renderHandleContainer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('You saved the world 10 years',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
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
                  image: new AssetImage('assets/bg_pet.png'),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: _renderContent()),
          ),
        ));
  }
}