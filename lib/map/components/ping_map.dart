import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mirae/map/components/google_maps_service.dart';
import 'package:mirae/map/components/menu_widget.dart';

import 'lets_go_widget.dart';

class PingMap extends StatefulWidget {
  final bool isPingWidget;
  PingMap({this.isPingWidget, Key key}) : super(key: key);
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

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  BitmapDescriptor pinLocationIcon;

  Set<Marker> _markers = Set.from([]);

  String navigateMsg = "";

  LatLng destination = LatLng(37.33186, -122.03045);
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

/*     print(lList.toString());
 */
    return lList;
  }

/* ------------------------------------ */

/* ------------------------------------ */

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff36AC56),
      ),
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
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ],
      ),
    );

    /* fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(seconds: 1),
    ); */

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 1),
        positionedToastBuilder: (context, child) {
          return Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height * 1 / 9)),
                child: child),
          );
        });
  }
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
    loading = true;
    toggleBtn = true;
    isArrived = true;
    fToast = FToast();
    fToast.init(context);

    getCurrentLocation();
    _markers = Set.from([]);
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    isPingWidget = widget.isPingWidget;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LatLng pinPosition = LatLng(35.149310, 129.063990);
    LatLng myPosition = location != null
        ? LatLng(location.latitude, location.longitude)
        : LatLng(35.149310, 129.063990);

/*     var threshold = 100;
 */
    return Scaffold(
        body: loading == false
            ? Stack(children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  child: GoogleMap(
                    polylines: polyLines,
                    initialCameraPosition: CameraPosition(
                      target: myPosition,
                      zoom: 18,
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
                /* GestureDetector(
                    onPanEnd: (details) {
                      if (details.velocity.pixelsPerSecond.dy > threshold) {
                        this.setState(() {
                          showBottomMenu = false;
                        });
                      } else if (details.velocity.pixelsPerSecond.dy <
                          -threshold) {
                        this.setState(() {
                          showBottomMenu = true;
                        });
                      }
                    },
                    child:  */
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) =>
                      isPingWidget == true,
                  widgetBuilder: (BuildContext context) =>
                      MenuWidget(pingMapState: this),
                  fallbackBuilder: (BuildContext context) =>
                      LetsGoWidget(pingMapState: this),
                ),
              ])
            : Center(child: Text("Loading...")),
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
              _showToast();

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
