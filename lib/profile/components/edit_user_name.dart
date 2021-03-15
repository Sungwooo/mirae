import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:provider/provider.dart';

class EditUserName extends StatefulWidget {
  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  FirebaseProvider fp;
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    currentUser = fp.getUser();
    return Column(
      children: [
        Container(
          width: 0.27 * width,
          child: TextField(
            cursorColor: Colors.green,
            cursorWidth: 1.0,
            decoration: InputDecoration(
              hintText: "${currentUser.displayName}",
              hintStyle: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontFamily: "GoogleSans",
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: 0.008 * width,
              ),
            ),
            textAlign: TextAlign.center,
            onChanged: (text) {
              print(text);
            },
            onSubmitted: (text) async {
              setState(() {
                fp.changeDisplayName(text);
              });
            },
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -7.0, 0.0),
          child: Image.asset(
            "assets/underline.png",
            width: 0.27 * width,
            height: 0.007 * height,
            color: Color(0xff42B261),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
