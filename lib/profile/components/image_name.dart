import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/profile/edit_profile.dart';

class ImageNameWidget extends StatelessWidget {
  FirebaseProvider fp;
  ImageNameWidget({this.fp});
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = fp.getUser();
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
          height: 0.006 * height,
        ),
        InkWell(
          onTap: () => Get.to(() => EditProfile()),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    currentUser.displayName != null
                        ? "${currentUser.displayName}"
                        : "Loading..",
                    style: TextStyle(
                        color: Color(0xff424242),
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Image.asset(
                    "assets/underline.png",
                    width: 0.24 * width,
                    height: 0.007 * height,
                    color: Color(0xff42B261),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 0.006 * height,
                  ),
                  Image.asset(
                    "assets/profileEdit.png",
                    width: 0.037 * width,
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
