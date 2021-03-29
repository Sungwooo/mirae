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
          : 'https://source.unsplash.com/Yui5vfKHuzs/640x404'
    });
  }
}
