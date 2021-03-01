import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/map/components/ping_map.dart';

class LetsGoMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "MAP",
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
      body: PingMap(
        isPingWidget: false,
      ),
    );
  }
}
