import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mirae/profile/edit_profile.dart';

class ImageNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Column(children: [
        CircleAvatar(
          radius: width * 0.13,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: (width * 0.13) - 2,
            backgroundImage: AssetImage('assets/profileImage.png'),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () => Get.to(() => EditProfile()),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Mad Max",
                    style: TextStyle(
                        color: Color(0xff424242),
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Image.asset(
                    "assets/underline.png",
                    width: 90,
                    height: 6,
                    color: Color(0xff42B261),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    "assets/profileEdit.png",
                    width: 14,
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
