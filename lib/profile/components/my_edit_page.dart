import 'package:flutter/material.dart';
import 'package:mirae/profile/components/edit_user_image.dart';
import 'package:mirae/profile/components/edit_user_info.dart';
import 'package:mirae/profile/components/edit_user_name.dart';
import 'package:mirae/profile/components/level_rank.dart';

class MyEditPage extends StatefulWidget {
  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xffF5F4F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.28 * height,
            child: Stack(children: [
              LevelRankWidget(),
              Positioned(
                  left: width * 0.368,
                  top: 0.165 * height,
                  child: EditImageNameWidget()),
              Positioned(
                left: width * 0.365,
                top: 0.215 * height,
                child: EditUserName(),
              )
            ]),
          ),
          SizedBox(
            height: 50,
          ),
          EditUserInfo(),
          SizedBox(
            height: 40,
          ),
          TextButton(
              onPressed: null,
              child: Text("LOG OUT",
                  style: TextStyle(
                      color: Color(0xffFF4646),
                      fontFamily: "GoogleSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
