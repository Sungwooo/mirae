import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/profile/edit_profile.dart';

class MyImageWidget extends StatelessWidget {
  FirebaseProvider fp;
  MyImageWidget({this.fp});
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = fp.getUser();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircleAvatar(
          radius: width * 0.12,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: (width * 0.12) - 2,
            backgroundImage: currentUser.photoUrl != null
                ? NetworkImage(currentUser.photoUrl, scale: 2)
                : AssetImage('assets/profileImage.png'),
          ),
        ),
      ]),
    );
  }
}
