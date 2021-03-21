import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Trash {
  double latitude;
  double longitude;

  Trash({this.latitude, this.longitude});

  factory Trash.fromJson(Map<String, dynamic> parsedJson) {
    return Trash(
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
    );
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
    loading = true;
    setCustomMapPin();
    getCurrentLocation();
    _markers = Set.from([]);
    loadTrashs().then((trashlist) {
      for (Trash trash in trashlist) {
        _markers.add(Marker(
            markerId: MarkerId('<MARKER_1>'),
            position: LatLng(trash.latitude, trash.longitude),
            icon: pinLocationIcon));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LatLng pinPosition = LatLng(35.149310, 129.063990);
    LatLng myPosition = location != null
        ? LatLng(location.latitude, location.longitude)
        : LatLng(35.149310, 129.063990);

/*     var threshold = 100;
 */
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
      body: loading == false
          ? Stack(children: <Widget>[
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
                    setState(() {
                      _markers.add(Marker(
                          markerId: MarkerId('<MARKER_1>'),
                          position: pinPosition,
                          icon: pinLocationIcon));
                      _markers.add(Marker(
                          markerId: MarkerId('<MARKER_2>'),
                          position: LatLng(37.33166, -122.03015),
                          icon: pinLocationIcon));
                      _markers.add(Marker(
                          markerId: MarkerId('<MARKER_3>'),
                          position: LatLng(37.33186, -122.03045),
                          icon: pinLocationIcon));
                    });
                  },
                ),
              ),
            ])
          : Container(
              height: height * 0.6,
              child: Center(
                child: Container(
                    width: width * 0.2,
                    height: width * 0.2,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff36A257)),
                    )),
              ),
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
