import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/trash_info.dart';

class Camera extends StatefulWidget {
  final CameraDescription camera;

  const Camera({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _renderTypeList(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Image.asset(
            'assets/ic_type_auto.png',
            width: 55.0,
            height: 110.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Image.asset(
            'assets/ic_type_paper.png',
            width: 55.0,
            height: 110.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Image.asset(
            'assets/ic_type_can.png',
            width: 55.0,
            height: 110.0,
          ),
        ),
      ],
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
              child: FlatButton(
                onPressed: () => Get.to(() => TrashInfo()),
                child: Container(
                  padding: EdgeInsets.all(4.0),
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
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/ic_ping.png',
                  width: 100.0,
                  height: 100.0,
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
        child: Text("Trash Type: Paper", style: TextStyle(color: Colors.white)),
        onPressed: () => printData(),
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
            Text('?', style: TextStyle(color: Colors.white, fontSize: 24)),
            Image.asset(
              'assets/ic_cancel.png',
              width: 14.0,
              height: 14.0,
            )
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
      appBar: AppBar(
          title: Text('PING',
              style: TextStyle(color: Color.fromRGBO(49, 172, 131, 1))),
          centerTitle: true),
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

void printData() {
  print('Hello');
}
