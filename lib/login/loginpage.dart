import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/sign_up.dart';
import 'package:mirae/mainPage/mainPage.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'firebase_provider.dart';

LogInState pageState;

class LogIn extends StatefulWidget {
  @override
  State createState() => LogInState();
}

class LogInState extends State<LogIn> {
  final _mailCon = TextEditingController();
  final _pwCon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.09),
            child: Image.asset(
              'assets/mirae_logo.png',
              width: 0.27 * width,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.122 * width),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID',
                          style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontSize: 0.037 * width,
                              fontWeight: FontWeight.w500,
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
                        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        child: Image.asset(
                          "assets/underline.png",
                          width: 0.756 * width,
                          height: 0.007 * height,
                          color: Color(0xff42B261),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: width * 0.05,
                      ),
                      Text('Password',
                          style: TextStyle(
                              color: Color(0xff7D7D7D),
                              fontSize: 0.037 * width,
                              fontWeight: FontWeight.w500,
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
                        obscureText: true,
                        onChanged: (text) {
                          print(text);
                        },
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        child: Image.asset(
                          "assets/underline.png",
                          width: 0.756 * width,
                          height: 0.007 * height,
                          color: Color(0xff42B261),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ].map((c) {
                      return c;
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.122 * width),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Container(
                        width: 0.27 * width,
                        height: 0.27 * width,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage('assets/btsignup.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async => _signIn(),
                      child: Container(
                        width: 0.27 * width,
                        height: 0.27 * width,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage('assets/btlogin.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              try {
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
              } catch (error) {
                print("error");
              }
            },
            child: Image.asset(
              'assets/signwithgg.png',
              width: 0.8 * width,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    print(fp.getUser());

    _scaffoldKey.currentState
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-In...")
          ],
        ),
      ));

    final result = await fp.signInWithEmail(_mailCon.text, _pwCon.text);

    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == null) showLastFBMessage();
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
