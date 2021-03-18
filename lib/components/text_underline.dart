import 'package:flutter/material.dart';

class TextUnderline extends StatelessWidget {
  final String message;
  final Color color;

  TextUnderline({this.message, this.color = Colors.white, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              fontSize: 0.048 * width),
        ),
        Image.asset(
          "assets/underline.png",
          width: (msgLength.toDouble() * 0.024 * width),
          height: 0.007 * height,
          color: color,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
