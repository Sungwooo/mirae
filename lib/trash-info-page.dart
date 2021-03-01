import 'dart:ui';
import 'package:flutter/material.dart';

class TrashInfo extends StatefulWidget {
  @override
  _TrashInfoState createState() => _TrashInfoState();
}

class _TrashInfoState extends State<TrashInfo> {
  Widget _renderRecycleButton() {
    return Container(
      width: 150,
      child: FlatButton(
        onPressed: () => {},
        color: Color.fromRGBO(72, 167, 255, 0.8),
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/ic_recycle_white.png', width: 20, height: 20),
            Text("Recyclables",
                style: TextStyle(fontSize: 16, color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _renderHandleContainer() {
    return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text("How to handle",
                style: TextStyle(fontSize: 28, color: Colors.black)),
            Image.asset('assets/handline_green.png',
                width: double.infinity, height: 10),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("How ddasdasd sadasdasd sadasdsada",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    )),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/ic_number_1.png', width: 30, height: 30),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text("How ddasdasd sadasdasd sadasdsada",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    )),
              ],
            )
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
          child: Column(
            children: [
              Text("+ 40 poinsts",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Image.asset('assets/handline_white.png',
                  width: double.infinity, height: 10)
            ],
          )),
    );
  }

  Widget _renderContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        children: <Widget>[
          Text('PAPER',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: Colors.white)),
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
          Text('You saved the world 10 years',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white)),
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
                style: TextStyle(color: Color.fromRGBO(49, 172, 131, 1))),
            centerTitle: true),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage('assets/bg_trash.png'),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: _renderContent()),
          ),
        ));
  }
}
