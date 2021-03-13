import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/sign_in.dart';
import 'package:mirae/mainPage/mainPage.dart';

import '../main.dart';

class LogIn extends StatefulWidget {
  @override
  State createState() => LogInState();
}

class LogInState extends State<LogIn> {

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 79),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/mirae_logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Text('mE',
                        style: TextStyle(
                            color: Color(0xff31AC53),
                            fontSize: 25,
                            fontFamily: 'GoogleSans')),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 58, left: 46, right: 46),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID',
                      style: TextStyle(
                          color: Color(0xff7D7D7D),
                          fontSize: 14,
                          fontFamily: 'GoogleSans')),
                  TextField(
                    cursorColor: Colors.red,
                    cursorWidth: 4.0,
                    maxLength: 20,
                    obscureText: true,
                    onChanged: (text) {
                      print(text);
                    },
                    onSubmitted: (text) {
                      print('Submitted:$text');
                    },
                  ),
                  Text('Password',
                      style: TextStyle(
                          color: Color(0xff7D7D7D),
                          fontSize: 14,
                          fontFamily: 'GoogleSans')),
                  TextField(
                    cursorColor: Colors.red,
                    cursorWidth: 4.0,
                    maxLength: 20,
                    obscureText: true,
                    onChanged: (text) {
                      print(text);
                    },
                    onSubmitted: (text) {
                      print('Submitted:$text');
                    },
                  ),
                  Text('find ID/PW',
                      style: TextStyle(
                          color: Color(0xff7D7D7D),
                          fontSize: 12,
                          fontFamily: 'GoogleSans')),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/btsignup.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/btlogin.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: new GestureDetector(
              onTap: () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MainPage(cameras);
                        },
                      ),
                    );
                  }
                });
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/signwithgg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
