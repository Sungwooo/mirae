import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';

import 'package:loading/loading.dart';
import 'package:mirae/login/firebase_provider.dart';
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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: width * 0.1),
              child: Container(
                width: 0.187 * width,
                height: 0.187 * width,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/mirae_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                // Input Area
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.122 * width),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('E-mail',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 0.037 * width,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _mailCon,
                            onSaved: (value) => _mailCon.text = value.trim(),
                            cursorColor: Color(0xff42B261),
                            cursorWidth: 0.005 * width,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 0.008 * width,
                              ),
                            ),
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: Image.asset(
                              "assets/underline.png",
                              width: 0.756 * width,
                              height: 0.007 * height,
                              color: Color(0xff42B261),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 0.05 * width,
                          ),
                          Text('Name',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 0.037 * width,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _nameCon,
                            onSaved: (value) => _nameCon.text = value.trim(),
                            cursorColor: Color(0xff42B261),
                            cursorWidth: 0.005 * width,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 0.008 * width,
                              ),
                            ),
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: Image.asset(
                              "assets/underline.png",
                              width: 0.756 * width,
                              height: 0.007 * height,
                              color: Color(0xff42B261),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 0.05 * width,
                          ),
                          Text('Password',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 0.037 * width,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _pwCon,
                            onSaved: (value) => _pwCon.text = value.trim(),
                            cursorColor: Color(0xff42B261),
                            cursorWidth: 0.005 * width,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 0.008 * width,
                              ),
                            ),
                            //obscureText: true,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: Image.asset(
                              "assets/underline.png",
                              width: 0.756 * width,
                              height: 0.007 * height,
                              color: Color(0xff42B261),
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 0.05 * width,
                          ),
                          Text('Repeat Password',
                              style: TextStyle(
                                  color: Color(0xff7D7D7D),
                                  fontSize: 0.037 * width,
                                  fontFamily: 'GoogleSans')),
                          TextFormField(
                            controller: _pwChkCon,
                            onSaved: (value) => _pwChkCon.text = value.trim(),
                            validator: (value) {
                              if (value.isEmpty) return 'Empty';
                              if (value != _pwCon.text) return 'Not Match';
                              return null;
                            },
                            cursorColor: Color(0xff42B261),
                            cursorWidth: 0.005 * width,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 0.008 * width,
                              ),
                            ),
                            //obscureText: true,
                            onChanged: (text) {
                              print(text);
                            },
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: Image.asset(
                              "assets/underline.png",
                              width: 0.756 * width,
                              height: 0.007 * height,
                              color: Color(0xff42B261),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.122 * width),
              child: Container(
                height: 0.373 * width,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03 * height),
                      child: GestureDetector(
                        onTap: () {
                          if (_pwChkCon.text != _pwCon.text) {
                            showNotMatchPassword();
                          } else {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()); // 키보드 감춤
                            _signUp();
                          }
                        },
                        child: Container(
                          width: 0.267 * width,
                          height: 0.267 * width,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage('assets/btsignup.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
                          ),
                        );
                      },
                      child: Container(
                        width: 0.133 * width,
                        height: 0.133 * width,
                        child: Text('Log in',
                            style: TextStyle(
                                color: Color(0xff31AC53),
                                fontSize: 0.042 * width,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GoogleSans')),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                fp.signInWithGoogleAccount().then((result) {
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
              child: Image.asset(
                'assets/signwithgg.png',
                width: 0.8 * width,
                fit: BoxFit.contain,
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
            Loading(
                indicator: BallBeatIndicator(),
                size: 100,
                color: Color(0xff36A257)),
            Text("   Signing-Up...")
          ],
        ),
      ));
    bool result =
        await fp.signUpWithEmail(_mailCon.text, _pwCon.text, _nameCon.text);
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

  showNotMatchPassword() {
    _scaffoldKey.currentState
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text('Password Not Match'),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}
