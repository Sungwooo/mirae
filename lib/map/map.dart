import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/auth_page.dart';

import 'components/ping_map.dart';

class MapPage extends StatelessWidget {
  final bool getPoints;
  const MapPage(this.getPoints);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "MAP",
          style: TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
        ),
        padding: EdgeInsetsDirectional.only(),
        leading: GestureDetector(
          child: Icon(
            CupertinoIcons.back,
            color: Color(0xff31AC53),
          ),
          onTap: () {
            Get.offAll(() => AuthPage());
          },
        ),
      ),
      body: PingMap(
        isPingWidget: true,
        getPoints: getPoints,
      ),
    );
  }
}
