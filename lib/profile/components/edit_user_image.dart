import 'package:flutter/material.dart';

class EditImageNameWidget extends StatefulWidget {
  @override
  _EditImageNameWidgetState createState() => _EditImageNameWidgetState();
}

class _EditImageNameWidgetState extends State<EditImageNameWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Column(children: [
        CircleAvatar(
          radius: width * 0.12,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: (width * 0.12) - 2,
            backgroundImage: AssetImage('assets/EditProfileImage.png'),
          ),
        ),
      ]),
    );
  }
}
