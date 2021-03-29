import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:loading/loading.dart';

import 'package:location/location.dart';
import 'package:mirae/map/components/google_maps_service.dart';
import 'package:mirae/map/components/menu_widget.dart';
import 'lets_go_widget.dart';

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

class PingMap extends StatefulWidget {
  final bool isPingWidget;
  final bool getPoints;

  const PingMap({this.isPingWidget, this.getPoints, key}) : super(key: key);
  @override
  PingMapState createState() => PingMapState();
}

class PingMapState extends State<PingMap> {
  FToast fToast;

  LocationData location;
  bool loading;
  bool toggleBtn;

  bool isPingWidget;
  bool isArrived;
  bool getPoints;

  Future<List> trashList;

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  BitmapDescriptor pinLocationIcon;

  Set<Marker> _markers = Set.from([]);

  String navigateMsg = "";

  LatLng destination = LatLng(37.3264, -122.0197);

/* ------------------------------------ */
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  static LatLng latLng;

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    String route = await _googleMapsServices.getRouteCoordinates(
        LatLng(location.latitude, location.longitude), destination);
    if (route == "Not Supported this location.") {
      setNavigateMessage("Not Supported this location.");
    } else {
      String msg = await _googleMapsServices?.getNavigateSteps(
          LatLng(location.latitude, location.longitude), destination);
      setNavigateMessage(msg);
      createRoute(route);
    }
  }

  void sendAutoRequest(myLocation) async {
    String route = await _googleMapsServices.getRouteCoordinates(
        LatLng(myLocation.latitude, myLocation.longitude), destination);

    if (route == "Not Supported this location.") {
      setNavigateMessage("Not Supported this location.");
    } else {
      String msg = await _googleMapsServices.getNavigateSteps(
          LatLng(myLocation.latitude, myLocation.longitude), destination);
      setNavigateMessage(msg);
      _polyLines.clear();
      createRoute(route);
    }
  }

  void sendNavigateRequest() async {
    String msg = await _googleMapsServices.getNavigateSteps(
        LatLng(location.latitude, location.longitude), destination);
    setNavigateMessage(msg);
  }

  setNavigateMessage(String value) {
    setState(() {
      navigateMsg = value;
    });
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
      polylineId: PolylineId(latLng.toString()),
      width: 4,
      points: _convertToLatLng(_decodePoly(encondedPoly)),
      color: Color(0xff36AC56),
      endCap: Cap.squareCap,
      geodesic: false,
      patterns: [PatternItem.dot, PatternItem.gap(10)],
    ));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    return lList;
  }

/* ------------------------------------ */

/* ------------------------------------ */

  /* _showToast() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget toast = Container(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 4.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff48A7FF).withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "+ 20 points",
                  style: TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 0.027 * width,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xff36AC56).withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icon/map/checkIcon.png",
                  width: 26,
                  height: 26,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "PING added",
                  style: TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 0.037 * width,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );



    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Align(
            alignment: Alignment.center,
            child: Container(margin: EdgeInsets.only(top: 400), child: child),
          );
        });
  } */
/* ------------------------------------ */

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
    toggleBtn = true;
    isArrived = false;
    setCustomMapPin();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentLocation();
    });
    _markers = Set.from([]);
  }

  @override
  Widget build(BuildContext context) {
    isPingWidget = widget.isPingWidget;
    getPoints = widget.getPoints;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LatLng myPosition = location != null
        ? LatLng(location.latitude, location.longitude)
        : LatLng(35.149310, 129.063990);

    return Scaffold(
        body: FutureBuilder<TrashsList>(
          future: trashsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var distance = (location.latitude - destination.latitude).abs() +
                  (location.longitude - destination.longitude).abs();
              for (Trash trash in snapshot.data.trashs) {
                var newDistance = (location.latitude - trash.latitude).abs() +
                    (location.longitude - trash.longitude).abs();
                if (distance > newDistance) {
                  setState(() {
                    destination = LatLng(trash.latitude, trash.longitude);
                  });
                }
              }
              return Stack(children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  child: GoogleMap(
                    polylines: polyLines,
                    initialCameraPosition: CameraPosition(
                      target: myPosition,
                      zoom: 14,
                    ),
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                    markers: (marker != null)
                        ? _markers.union(Set.of([marker]))
                        : _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;

                      snapshot.data.trashs
                          .asMap()
                          .forEach((index, Trash trash) {
                        _markers.add(Marker(
                            markerId: MarkerId('<MARKER_$index>'),
                            position: LatLng(trash.latitude, trash.longitude),
                            icon: pinLocationIcon));
                      });
                      if (getPoints == true) {
                        _markers.add(Marker(
                            markerId: MarkerId('<MARKER_1>'),
                            position: myPosition,
                            icon: pinLocationIcon));
                      }
                    },
                  ),
                ),
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) =>
                      isPingWidget == true,
                  widgetBuilder: (BuildContext context) =>
                      MenuWidget(pingMapState: this),
                  fallbackBuilder: (BuildContext context) =>
                      LetsGoWidget(pingMapState: this),
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
        floatingActionButton: FloatingActionButton(
            heroTag: 'one',
            mini: true,
            foregroundColor: Color(0xff31AC53),
            child: toggleBtn
                ? ImageIcon(
                    AssetImage("assets/icon/map/locationOffBtn.png"),
                    size: width * 0.05,
                  )
                : ImageIcon(
                    AssetImage("assets/icon/map/locationOnBtn.png"),
                    size: width * 0.05,
                  ),
            backgroundColor: Colors.white.withOpacity(0.7),
            onPressed: () {
              getCurrentLocation();
              toggleBtn = !toggleBtn;
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop);
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

      if (!toggleBtn) {
        _locationSubscription =
            _locationTracker.onLocationChanged.listen((newLocalData) {
          if (_controller != null) {
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                new CameraPosition(
                    target: LatLng(
                        newLocalData.latitude - 0.0005, newLocalData.longitude),
                    tilt: 0,
                    zoom: 18.00)));
            if ((newLocalData.latitude - destination.latitude).abs() +
                    (newLocalData.longitude - destination.longitude).abs() <
                0.0015) {
              setState(() {
                isArrived = true;
              });
            }
            updateMarkerAndCircle(newLocalData, imageData);
            sendAutoRequest(newLocalData);
          }
        });
      } else {
        _locationSubscription =
            _locationTracker.onLocationChanged.listen((newLocalData) {
          if (_controller != null) {
            updateMarkerAndCircle(newLocalData, imageData);
          }
        });
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(location.latitude, location.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(location, imageData);
        }
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
