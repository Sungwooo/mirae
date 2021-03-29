import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final databaseReference = FirebaseDatabase.instance.reference().child('user');

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
                  fontSize: 0.053 * width,
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
              changeNickName(text);
            },
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -7.0, 0.0),
          child: Image.asset(
            "assets/underline.png",
            width: currentUser.displayName.length * width * 0.058,
            height: 0.007 * height,
            color: Color(0xff42B261),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  void changeNickName(String text) async {
    await fp.changeDisplayName(text);
    await databaseReference
        .child(fp.getUser().uid)
        .update({'name': text != '' ? text : fp.getUser().displayName});
  }
}
