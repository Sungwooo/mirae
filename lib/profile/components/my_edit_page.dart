import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/auth_page.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/profile/components/edit_user_image.dart';
import 'package:mirae/profile/components/edit_user_info.dart';
import 'package:mirae/profile/components/edit_user_name.dart';
import 'package:mirae/profile/components/level_rank.dart';
import 'package:provider/provider.dart';

class MyEditPage extends StatefulWidget {
  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xffF5F4F4),
      child: ListView(
        children: [
          Container(
            height: 0.476 * width,
            child: Stack(
              children: [
                LevelRankWidget(
                  fp: fp,
                ),
                Positioned(
                    top: 0.23 * width,
                    left: 0.39 * width,
                    child: EditImageNameWidget()),
              ],
            ),
          ),
          EditUserName(),
          SizedBox(
            height: 0.06 * height,
          ),
          EditUserInfo(),
          SizedBox(
            height: 0.05 * height,
          ),
          TextButton(
              onPressed: () async {
                await fp.signOut();
                Get.offAll(AuthPage());
              },
              child: Text("LOG OUT",
                  style: TextStyle(
                      color: Color(0xffFF4646),
                      fontFamily: "GoogleSans",
                      fontSize: 0.048 * width,
                      fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
