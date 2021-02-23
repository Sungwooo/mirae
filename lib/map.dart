import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Geolocator geolocator = Geolocator();
  Position _currentPosition;
  bool loading;

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _markers = Set.from([]);
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/icon/map/trashMarker.png");
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPostion = LatLng(35.149310, 129.063990);
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text(
            "MAP",
            style:
                TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
          ),
        ),
        body: _currentPosition != null && loading == false
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _currentPosition.latitude, _currentPosition.longitude),
                    zoom: 18,
                  ),
                  myLocationEnabled: true,
                  compassEnabled: true,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    setState(() {
                      _markers.add(Marker(
                          markerId: MarkerId('<MARKER_ID>'),
                          position: pinPostion,
                          icon: pinLocationIcon));
                    });
                  },
                ))
            : null);
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
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
