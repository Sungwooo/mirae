import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mirae/camera/trash_info_can.dart';
import 'package:mirae/camera/trash_info_glass.dart';
import 'package:mirae/camera/trash_info_paper.dart';
import 'package:mirae/camera/trash_info_plastic.dart';
import 'package:mirae/map/map_splash.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bounding_box.dart';

class TrashType {
  String title;
  String iconPath;

  TrashType({this.title, this.iconPath});
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int selectedTypeIndex = 0;
  List<TrashType> typeList = [];
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isDetecting = false;
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  Future<void> _cameraInitialize() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      _controller.startImageStream((CameraImage img) {
        if (!isDetecting) {
          isDetecting = true;
          Tflite.detectObjectOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            model: "SSDMobileNet",
            imageHeight: img.height,
            imageWidth: img.width,
            imageMean: 127.5,
            imageStd: 127.5,
            numResultsPerClass: 1,
            threshold: 0.4,
          ).then((recognitions) {
            setState(() {
              _recognitions = recognitions;
              _imageHeight = img.height;
              _imageWidth = img.width;
            });
            isDetecting = false;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    typeList.add(
        TrashType(title: "Auto", iconPath: "assets/ic_type_unselected.png"));
    typeList
        .add(TrashType(title: "Paper", iconPath: "assets/ic_type_paper2.png"));
    typeList.add(TrashType(title: "Can", iconPath: "assets/ic_type_can2.png"));
    typeList.add(
        TrashType(title: "Plastic", iconPath: "assets/ic_type_plastic.png"));
    typeList
        .add(TrashType(title: "Glass", iconPath: "assets/ic_type_glass.png"));
    typeList.add(
        TrashType(title: "Plastic bag", iconPath: "assets/ic_type_pbag.png"));
    typeList.add(TrashType(title: "Food", iconPath: "assets/ic_type_food.png"));

    _cameraInitialize();

    loadTfModel();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleAutoRouting(String imagePath) async {
    var objectName = _recognitions.reduce((current, next) =>
        current['confidenceInClass'] > next['confidenceInClass']
            ? current
            : next)["detectedClass"];
    if (objectName == 'Can') {
      Get.to(() => TrashInfoCan(widget.cameras, imagePath));
      return;
    }
    if (objectName == 'Plastic') {
      Get.to(() => TrashInfoPlastic(widget.cameras, imagePath));
      return;
    }
    if (objectName == 'Glass') {
      Get.to(() => TrashInfoGlass(widget.cameras, imagePath));
      return;
    }
    if (objectName == 'Paper') {
      Get.to(() => TrashInfoPaper(widget.cameras, imagePath));
      return;
    }

    Fluttertoast.showToast(msg: "Unkown trash type");

    _controller.startImageStream((CameraImage img) {
      if (!isDetecting) {
        isDetecting = true;
        Tflite.detectObjectOnFrame(
          bytesList: img.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          model: "SSDMobileNet",
          imageHeight: img.height,
          imageWidth: img.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResultsPerClass: 1,
          threshold: 0.4,
        ).then((recognitions) {
          setState(() {
            _recognitions = recognitions;
            _imageHeight = img.height;
            _imageWidth = img.width;
          });
          isDetecting = false;
        });
      }
    });
  }

  Future<void> _onDiscardPress() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    if (_recognitions == null || _recognitions.isEmpty) {
      Fluttertoast.showToast(msg: "No object detected");
      return;
    }

    try {
      await _controller.stopImageStream();
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      final image = await _controller.takePicture();
      if (selectedTypeIndex == 1) {
        Get.to(() => TrashInfoPaper(widget.cameras, image.path));
        return;
      }
      if (selectedTypeIndex == 2) {
        Get.to(() => TrashInfoCan(widget.cameras, image.path));
        return;
      }
      if (selectedTypeIndex == 3) {
        Get.to(() => TrashInfoPlastic(widget.cameras, image.path));
        return;
      }
      if (selectedTypeIndex == 4) {
        Get.to(() => TrashInfoGlass(widget.cameras, image.path));
        return;
      }

      _handleAutoRouting(image.path);
    } on CameraException catch (e) {
    }
  }

  void _onPingPress() {
    if (_recognitions == null || _recognitions.isEmpty) {
      Fluttertoast.showToast(msg: "No object detected");
      return;
    }
    var objectName = _recognitions.reduce((current, next) =>
        current['confidenceInClass'] > next['confidenceInClass']
            ? current
            : next)["detectedClass"];
    if (objectName == 'unknown') {
      Fluttertoast.showToast(msg: "No object detected");
      return;
    }

    Get.to(() => MapSplash());
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
    double width = MediaQuery.of(context).size.width;

    Widget _renderTypeWithIcon(index) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            index == selectedTypeIndex
                ? 'assets/ic_type_selected.png'
                : 'assets/ic_type_unselected.png',
            width: 55.0,
            height: 70.0,
          ),
          Image.asset(
            typeList[index].iconPath,
            width: 30.0,
            height: 30.0,
          )
        ],
      );
    }

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
                        fontSize: 0.037 * width,
                        color: index == selectedTypeIndex
                            ? Color.fromRGBO(54, 174, 87, 1)
                            : Colors.white,
                        fontFamily: 'GoogleSans',
                        fontWeight: FontWeight.w500)),
                _renderTypeWithIcon(index),
              ],
            )));
  }

  Widget _renderTypeList(BuildContext context) {
    final vpWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: EdgeInsets.only(left: vpWidth / 3),
      scrollDirection: Axis.horizontal,
      itemCount: typeList.length,
      itemBuilder: (context, index) {
        return _renderTypeItem(context, index);
      },
    );
  }

  Widget _renderButtons(BuildContext context) {
    String getValidCenter() {
      if (selectedTypeIndex == 5) {
        return 'assets/ic_landfill.png';
      }
      if (selectedTypeIndex == 6) {
        return 'assets/ic_compostables.png';
      }

      return 'assets/ic_recycle.png';
    }

    List<double> getValidCenterSize() {
      if (selectedTypeIndex == 5) {
        return [60.0, 100.0];
      }
      if (selectedTypeIndex == 6) {
        return [110.0, 100.0];
      }

      return [90.0, 100.0];
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
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
                      onTap: _onPingPress,
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
                      getValidCenter(),
                      width: getValidCenterSize()[0],
                      height: getValidCenterSize()[1],
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: _onDiscardPress,
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
          ],
        ));
  }

  Widget _renderCurrentType(BuildContext context) {
    var objectName = _recognitions == null || _recognitions.isEmpty
        ? typeList[selectedTypeIndex].title
        : selectedTypeIndex != 0
            ? typeList[selectedTypeIndex].title
            : _recognitions.reduce((current, next) =>
                current['confidenceInClass'] > next['confidenceInClass']
                    ? current
                    : next)["detectedClass"];
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: FlatButton(
        color: Color.fromRGBO(54, 174, 87, 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text("Trash Type: $objectName",
            style: TextStyle(color: Colors.white)),
        onPressed: () => {},
      ),
    );
  }

  Widget _renderTopContainer(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  style:
                      TextStyle(color: Colors.white, fontSize: 0.064 * width)),
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
      padding: EdgeInsets.symmetric(vertical: 20.0),
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
    final Size screen = MediaQuery.of(context).size;
    final deviceRatio = screen.width / screen.height;
    return Container(
      child: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1,
            child: Center(
              child: AspectRatio(
                aspectRatio: deviceRatio,
                child: CameraPreview(_controller),
              ),
            ),
          ),
          BoundingBox(
            _recognitions == null || _recognitions.isEmpty
                ? []
                : [
                    _recognitions.reduce((current, next) =>
                        current['confidenceInClass'] > next['confidenceInClass']
                            ? current
                            : next)
                  ],
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
          ),
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
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 0.0, // One physical pixel.
            style: BorderStyle.none,
          ),
        ),
        middle: Text(
          "CAMERA",
          style: TextStyle(
              color: Color(0xff31AC53),
              fontWeight: FontWeight.w700,
              fontFamily: 'GoogleSans'),
        ),
        padding: EdgeInsetsDirectional.only(),
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
