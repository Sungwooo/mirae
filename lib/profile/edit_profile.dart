import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/profile/components/my_edit_page.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          "MY",
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
      resizeToAvoidBottomInset: false,
      body: MyEditPage(),
    );
  }
}
