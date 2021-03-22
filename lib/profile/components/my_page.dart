import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:mirae/profile/components/my_image.dart';
import 'package:mirae/profile/components/level_rank.dart';
import 'package:mirae/profile/components/my_name.dart';
import 'package:mirae/profile/components/my_ping_btn.dart';
import 'package:mirae/profile/components/my_score_box.dart';
import 'package:mirae/profile/components/progress_bar.dart';
import 'package:provider/provider.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xffF5F4F4),
      child: ListView(
        children: [
          Container(
            height: 0.476 * width,
            child: Stack(children: [
              LevelRankWidget(
                fp: fp,
              ),
              Positioned(
                top: 0.23 * width,
                left: 0.39 * width,
                child: MyImageWidget(
                  fp: fp,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 0.009 * height,
          ),
          MyNameWidget(
            fp: fp,
          ),
          SizedBox(
            height: 0.009 * height,
          ),
          MyPingButtonWidget(),
          ProgressBarWidget(),
          MyScoreBoxWidget(),
          SizedBox(
            height: 0.015 * height,
          )
        ],
      ),
    );
  }
}
