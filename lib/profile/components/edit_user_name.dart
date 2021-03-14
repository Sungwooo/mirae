import 'package:flutter/material.dart';

class EditUserName extends StatefulWidget {
  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  String userDisplayName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          child: TextField(
            cursorColor: Colors.green,
            cursorWidth: 1.0,
            decoration: InputDecoration(
              hintText: "    Name",
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
                left: 3,
              ),
            ),
            onChanged: (text) {
              print(text);
            },
            onSubmitted: (text) {
              setState(() {
                userDisplayName = text;
              });
            },
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -7.0, 0.0),
          child: Image.asset(
            "assets/underline.png",
            width: 100,
            height: 6,
            color: Color(0xff42B261),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
