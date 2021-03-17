import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/profile/edit_profile.dart';

class MyNameWidget extends StatelessWidget {
  FirebaseProvider fp;
  MyNameWidget({this.fp});
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = fp.getUser();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        InkWell(
          onTap: () => Get.to(() => EditProfile()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 0.037 * width,
              ),
              Column(
                children: [
                  Text(
                    currentUser.displayName != null
                        ? "${currentUser.displayName}"
                        : "Loading..",
                    style: TextStyle(
                        color: Color(0xff424242),
                        fontFamily: "GoogleSans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Image.asset(
                    "assets/underline.png",
                    width: currentUser.displayName.length * width * 0.052,
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
