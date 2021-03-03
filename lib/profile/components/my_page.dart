import 'package:flutter/material.dart';
import 'package:mirae/profile/components/image_name.dart';
import 'package:mirae/profile/components/level_rank.dart';
import 'package:mirae/profile/components/my_ping_btn.dart';
import 'package:mirae/profile/components/my_score_box.dart';
import 'package:mirae/profile/components/progress_bar.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xffF5F4F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.27 * height,
            child: Stack(children: [
              LevelRankWidget(),
              Positioned(
                  left: width * 0.368,
                  top: 0.165 * height,
                  child: ImageNameWidget()),
            ]),
          ),
          MyPingButtonWidget(),
          ProgressBarWidget(),
          MyScoreBoxWidget(),
        ],
      ),
    );
  }
}
