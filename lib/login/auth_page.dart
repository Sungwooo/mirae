import 'package:flutter/material.dart';
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
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null) {
      return MainPage(cameras);
    } else {
      return LogIn();
    }
  }
}
