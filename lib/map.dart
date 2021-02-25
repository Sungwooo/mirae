import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mirae/map/menu_widget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Geolocator geolocator = Geolocator();
  Position _currentPosition;
  bool loading;
  bool toggleBtn;

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  BitmapDescriptor pinLocationIcon;

  Set<Marker> _markers = Set.from([]);

  bool showBottomMenu = false;

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
    _getMyLocation();
    _markers = Set.from([]);
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    LatLng pinPostion = LatLng(35.149310, 129.063990);
    LatLng myPosition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

/*     var threshold = 100;
 */
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text(
            "MAP",
            style:
                TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _currentPosition != null && loading == false
            ? Stack(children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: myPosition,
                      zoom: 18,
                    ),
                    myLocationButtonEnabled: false,
                    markers: (marker != null)
                        ? _markers.union(Set.of([marker]))
                        : _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      setState(() {
                        _markers.add(Marker(
                            markerId: MarkerId('<MARKER_1>'),
                            position: pinPostion,
                            icon: pinLocationIcon));
                        _markers.add(Marker(
                            markerId: MarkerId('<MARKER_2>'),
                            position: LatLng(35.150310, 129.063990),
                            icon: pinLocationIcon));
                        _markers.add(Marker(
                            markerId: MarkerId('<MARKER_3>'),
                            position: LatLng(35.149310, 129.063490),
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
                AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200),
                    left: 0,
                    bottom: (showBottomMenu) ? -60 : -(height * 4 / 9) + 25,
                    child: MenuWidget()),
              ])
            : null,
        floatingActionButton: FloatingActionButton.extended(
            icon: toggleBtn
                ? Icon(Icons.location_disabled)
                : Icon(Icons.location_searching),
            label: Text(''),
            backgroundColor: Colors.white,
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
      var location = await _locationTracker.getLocation();

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
                    bearing: 192.8334901395799,
                    target:
                        LatLng(newLocalData.latitude, newLocalData.longitude),
                    tilt: 0,
                    zoom: 18.00)));
            updateMarkerAndCircle(newLocalData, imageData);
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
    }
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/icon/map/trashMarker.png");
  }

  _getMyLocation() async {
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
        loading = false;
        print(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
