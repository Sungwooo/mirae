import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/login/sign_in.dart';
import 'package:mirae/mainPage/mainPage.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'loginpage.dart';

SignUpPageState pageState;

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() {
    pageState = SignUpPageState();
    return pageState;
  }
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _nameCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _pwChkCon = TextEditingController();


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
    _nameCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (fp == null) {
      fp = Provider.of<FirebaseProvider>(context);
    }

    return Scaffold(
        resizeToAvoidBottomInset : false,
        key: _scaffoldKey,
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: <Widget>[
                  //Header
                  Padding(
                    padding: const EdgeInsets.only(top: 79),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('assets/mirae_logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Input Area
                  Padding(
                    padding: const EdgeInsets.only(top: 58, left: 46, right: 46),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('E-mail',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 14,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _mailCon,
                            onSaved: (value) => _mailCon.text = value.trim(),
                            cursorColor: Colors.red,
                            cursorWidth: 4.0,
                            maxLength: 20,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Text('Name',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 14,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _nameCon,
                            onSaved: (value) => _nameCon.text = value.trim(),
                            cursorColor: Colors.red,
                            cursorWidth: 4.0,
                            maxLength: 20,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Text('Password',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 14,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _pwCon,
                            onSaved: (value) => _pwCon.text = value.trim(),
                            cursorColor: Colors.red,
                            cursorWidth: 4.0,
                            maxLength: 20,
                            obscureText: true,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Text('Repeat Password',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 14,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _pwChkCon,
                            validator: (val){
                              if(val.isEmpty)
                                return 'Empty';
                              if(val != _pwCon.text)
                                return 'Not Match';
                              return null;
                            },
                            cursorColor: Colors.red,
                            cursorWidth: 4.0,
                            maxLength: 20,
                            obscureText: true,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                        ].map((c) {
                          return c;
                        }).toList(),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                FocusScope.of(context)
                    .requestFocus(new FocusNode()); // 키보드 감춤
                _signUp();
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/btsignup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                LogIn();
              },
              child : Container(
                width: 50,
                height: 50,
                child: Text('Log in',
                    style: TextStyle(
                        color: Color(0xff31AC53),
                        fontSize: 16,
                        fontFamily: 'GoogleSans')
                ),
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
                            return MainPage(cameras);},
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
        ));
  }

  void _signUp() async {
    _scaffoldKey.currentState
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-Up...")
          ],
        ),
      ));
    bool result = await fp.signUpWithEmail(_mailCon.text, _pwCon.text, _nameCon.text);
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result) {
      Navigator.pop(context);
    } else {
      showLastFBMessage();
    }
  }

  showLastFBMessage() {
    _scaffoldKey.currentState
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}