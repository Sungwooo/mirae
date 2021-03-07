import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/camera/trash_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../map/map.dart';

class TrashType {
  String title;

  TrashType({this.title});
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int selectedTypeIndex = 0;
  List<TrashType> typeList = new List();
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraInitialize();

    typeList.add(TrashType(title: "Auto"));
    typeList.add(TrashType(title: "Paper"));
    typeList.add(TrashType(title: "Can"));

    Future.delayed(Duration(seconds: 3), () {
      // _captureImage();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _cameraInitialize() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  _captureImage() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    } on CameraException catch (e) {}
  }

  _launchHelpURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _renderTypeItem(BuildContext context, index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  selectedTypeIndex = index;
                }),
            child: Column(
              children: [
                Text(typeList[index].title,
                    style: TextStyle(
                        fontSize: 14,
                        color: index == selectedTypeIndex
                            ? Color.fromRGBO(54, 174, 87, 1)
                            : Colors.white,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500)),
                Image.asset(
                  index == selectedTypeIndex
                      ? 'assets/ic_type_selected.png'
                      : 'assets/ic_type_unselected.png',
                  width: 55.0,
                  height: 70.0,
                ),
              ],
            )));
  }

  Widget _renderTypeList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: typeList.length,
      itemBuilder: (context, index) {
        return _renderTypeItem(context, index);
      },
    );
  }

  Widget _renderButtons(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  ),
                  child: Image.asset(
                    'assets/ic_ping.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/ic_recycle.png',
                  width: 90.0,
                  height: 100.0,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              child: FlatButton(
                onPressed: () => Get.to(() => TrashInfo(widget.cameras)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Image.asset(
                      'assets/ic_discard.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderCurrentType(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: FlatButton(
        color: Color.fromRGBO(54, 174, 87, 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text("Trash Type: ${typeList[selectedTypeIndex].title}",
            style: TextStyle(color: Colors.white)),
        onPressed: () => {},
      ),
    );
  }

  Widget _renderTopContainer(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80.0,
        padding: EdgeInsets.all(20.0),
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _launchHelpURL(),
              child: Text('?',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/ic_cancel.png',
                  width: 14.0,
                  height: 14.0,
                )),
          ],
        ));
  }

  Widget _renderButtonContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240.0,
      padding: EdgeInsets.all(20.0),
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Column(
        children: [
          Expanded(child: _renderTypeList(context)),
          _renderButtons(context),
        ],
      ),
    );
  }

  Widget _renderCameraView(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Align(
              alignment: Alignment.topCenter,
              child: _renderTopContainer(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _renderCurrentType(context),
              _renderButtonContainer(context)
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "CAMERA",
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
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _renderCameraView(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
