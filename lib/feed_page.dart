import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: null,
            icon: ImageIcon(
              AssetImage('assets/actionbar_camera.png'),
              color: Colors.black,
            ),
          ),
          title: Image.asset(
            'assets/insta_text_logo.png',
            height: 26,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/actionbar_camera.png'),
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/direct_message.png'),
                color: Colors.black,
              ),
            ),
          ],
        )
    );
  }
}