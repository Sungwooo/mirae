import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mirae/global.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../mainPage/mainPage.dart';
import 'firebase_provider.dart';
import 'loginpage.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  final databaseReference = FirebaseDatabase.instance.reference().child('user');
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null) {
      Globals.changeUid(fp.getUser().uid);
      searchData();
      return MainPage(cameras);
    } else {
      return LogIn();
    }
  }

  // ignore: missing_return
  Future<bool> searchData() async {
    try {
      fp = Provider.of<FirebaseProvider>(context);
      databaseReference
          .child(fp.getUser().uid)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          createData();
        }
      });
    } on Exception catch (e) {}
  }

  void createData() async {
    await databaseReference.child(fp.getUser().uid).set({
      'name': fp.getUser().displayName,
      'country': 'US',
      'discard': 0,
      'point': 0,
      'ping': 0,
      'ImageUrl': fp.getUser().photoUrl != null
          ? fp.getUser().photoUrl
          : 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAzMDdfMTQ2%2FMDAxNjE1MDk3MjM1MDY4.8Vv_CZkS8JeQmLyZ9hZ-v1Xl_g34aOftc-Ig0hKMuuog.OPqz0oZcuR_5oekb2Dgw0s3Yt2rtdS4zvPtP2E_4WsQg.JPEG.eeeuz%2F%25B9%25AB%25BE%25DF%25C8%25A3%25C2%25A93.jpg&type=sc960_832'
    });
  }
}
