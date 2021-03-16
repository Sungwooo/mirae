import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:provider/provider.dart';

import 'components/ping_map.dart';

class MapPage extends StatelessWidget {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);

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
        isPingWidget: true,
      ),
    );
  }
}
