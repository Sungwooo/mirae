import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirae/profile/components/my_page.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "MY",
          style: TextStyle(color: Color(0xff31AC53), fontFamily: 'GoogleSans'),
        ),
      ),
      body: MyInfoPage(),
    );
  }
}
