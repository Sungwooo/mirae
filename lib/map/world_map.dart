import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:loading/loading.dart';
import 'package:location/location.dart';

class Trash {
  final double latitude;
  final double longitude;
  final String uid;

  Trash({this.latitude, this.longitude, this.uid});

  factory Trash.fromJson(Map<String, dynamic> json) {
    return Trash(
      latitude: json['latitude'],
      longitude: json['longitude'],
      uid: json['uid'],
    );
  }
}

Future<TrashsList> fetchPost() async {
  final response = await http
      .get('https://mirae-caa74-default-rtdb.firebaseio.com/ping.json');

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return TrashsList.fromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class TrashsList {
  final List<Trash> trashs;

  TrashsList({
    this.trashs,
  });
  factory TrashsList.fromJson(List<dynamic> parsedJson) {
    List<Trash> trashs = new List<Trash>();
    trashs = parsedJson.map((i) => Trash.fromJson(i)).toList();

    return new TrashsList(
      trashs: trashs,
    );
  }
}

Future<TrashsList> trashsList;

Future<String> _loadTrashAsset() async {
  return await rootBundle.loadString('assets/data/trash_list.json');
}

Future loadTrashs() async {
  String jsonString = await _loadTrashAsset();
  final jsonResponse = json.decode(jsonString);
  TrashsList trashs = new TrashsList.fromJson(jsonResponse);
  return trashs.trashs;
}

class WorldMap extends StatefulWidget {
  @override
  WorldMapState createState() => WorldMapState();
}

class WorldMapState extends State<WorldMap> {
  LocationData location;
  bool loading;
  Future<List> trashList;

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  BitmapDescriptor pinLocationIcon;

  Set<Marker> _markers = Set.from([]);

  LatLng destination = LatLng(37.33186, -122.03045);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    trashsList = fetchPost();
    loading = true;
    setCustomMapPin();
    getCurrentLocation();
    _markers = Set.from([]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LatLng myPosition = location != null
        ? LatLng(location.latitude, location.longitude)
        : LatLng(35.149310, 129.063990);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "WORLD MAP",
          style: TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
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
      body: FutureBuilder<TrashsList>(
        future: trashsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(children: <Widget>[
              Container(
                width: width,
                height: height,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: myPosition,
                    zoom: 1,
                  ),
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: (marker != null)
                      ? _markers.union(Set.of([marker]))
                      : _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    snapshot.data.trashs.asMap().forEach((index, Trash trash) {
                      _markers.add(Marker(
                          markerId: MarkerId('<MARKER_$index>'),
                          position: LatLng(trash.latitude, trash.longitude),
                          icon: pinLocationIcon));
                    });
                  },
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container(
            height: height * 0.6,
            child: Center(
              child: Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  child: Loading(
                      indicator: BallBeatIndicator(),
                      size: 0.27 * width,
                      color: Color(0xff36A257))),
            ),
          );
        },
      ),
    );
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/icon/map/myMarker.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      location = await _locationTracker.getLocation();
      setState(() {
        location = location;
        loading = false;
      });

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
      print("error!");
    }
  }

  Future<Uint8List> getTrashMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/icon/map/trashMarker.png");
    return byteData.buffer.asUint8List();
  }

  void setCustomMapPin() async {
    Uint8List trashIconData = await getTrashMarker();
    pinLocationIcon = BitmapDescriptor.fromBytes(trashIconData);
  }
}
