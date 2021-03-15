import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/sign_in.dart';
import 'package:mirae/login/sign_up.dart';
import 'package:mirae/mainPage/mainPage.dart';
import 'package:mirae/login/auth_page.dart';
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

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 120),
              child: Image.asset(
                'assets/mirae_logo.png',
                width: 100,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 46, right: 46),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID',
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
                  /*Text('find ID/PW',
                      style: TextStyle(
                          color: Color(0xff7D7D7D),
                          fontSize: 12,
                          fontFamily: 'GoogleSans')),*/
                ].map((c) {
                  return c;
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 46, right: 46),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Container(
                    width: 100,
                    height: 100,
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
                    width: 100,
                    height: 100,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/btlogin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: new GestureDetector(
              onTap: () {
                try {
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
                } catch (error) {
                  print("error");
                }
              },
              child: Image.asset(
                'assets/signwithgg.png',
                width: 300,
                fit: BoxFit.contain,
              ),
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
      ..hideCurrentSnackBar()
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
