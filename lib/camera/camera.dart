import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/camera/trash_info_can.dart';
import 'package:mirae/camera/trash_info_paper.dart';
import 'package:mirae/camera/trash_info_pet.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../map/map.dart';
import 'bounding_box.dart';

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
            bytesList: img.planes.map((plane) {return plane.bytes;}).toList(),
            model: "SSDMobileNet",
            imageHeight: img.height,
            imageWidth: img.width,
            imageMean: 127.5,
            imageStd: 127.5,
            numResultsPerClass: 1,
            threshold: 0.4,
            /*
              bytesList: img.planes.map((plane) {return plane.bytes;}).toList(),// required
              model: "YOLO",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 0,         // defaults to 127.5
              imageStd: 255.0,      // defaults to 127.5
              threshold: 0.1,       // defaults to 0.1
              numResultsPerClass: 2,// defaults to 5
              blockSize: 32,        // defaults to 32
              numBoxesPerBlock: 5,  // defaults to 5
              asynch: true          // defaults to true
             */
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

    _cameraInitialize();

    typeList.add(TrashType(title: "Auto"));
    typeList.add(TrashType(title: "Paper"));
    typeList.add(TrashType(title: "Can"));

    loadTfModel();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onDiscardPress() {
    if (selectedTypeIndex == 1) {
      Get.to(() => TrashInfoPaper(widget.cameras));
      return;
    }
    if (selectedTypeIndex == 2) {
      Get.to(() => TrashInfoCan(widget.cameras));
      return;
    }

    Get.to(() => TrashInfoPet(widget.cameras));
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
      child: GestureDetector(onTap: () => setState(() {
        selectedTypeIndex = index;
      }), child: Column(
        children: [
          Text(typeList[index].title, style: TextStyle(fontSize: 14, color: index == selectedTypeIndex ? Color.fromRGBO(54, 174, 87, 1) : Colors.white, fontFamily: 'GoogleSans', fontWeight: FontWeight.w500)),
          Image.asset(
            index == selectedTypeIndex ? 'assets/ic_type_selected.png' : 'assets/ic_type_unselected.png',
            width: 55.0,
            height: 70.0,
          ),
        ],
      )
    ));
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
                onPressed: _onDiscardPress,
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
        child: Text("Trash Type: ${typeList[selectedTypeIndex].title}", style: TextStyle(color: Colors.white)),
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
              child: Text('?', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/ic_cancel.png',
                width: 14.0,
                height: 14.0,
              )
            ),
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
    Size screen = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          CameraPreview(_controller),
          BoundingBox(
            _recognitions == null ? [] : _recognitions,
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
      appBar: AppBar(
          title: Text('Camera',
              style: TextStyle(
                  color: Color.fromRGBO(49, 172, 131, 1),
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w600)),
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
