import 'package:flutter/material.dart';

class TextUnderline extends StatelessWidget {
  final String message;
  final Color color;

  TextUnderline({this.message, this.color = Colors.white, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int msgLength = message.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$message",
          style: TextStyle(
              color: color,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        Image.asset(
          "assets/underline.png",
          width: (msgLength.toDouble() * 9),
          height: 6,
          color: color,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
