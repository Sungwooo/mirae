import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressBarWidget extends StatefulWidget {
  @override
  _ProgressBarWidgetState createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  int points = 54400;

  String numberWithComma(int param) {
    return new NumberFormat('###,###,###,###')
        .format(param)
        .replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: 0.009 * height),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffB1ECFF),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 0.06 * width, vertical: 0.02 * height),
          child: Column(
            children: [
              Container(
                height: 0.15 * height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 83,
                        height: points > 6500 ? 107 : 107 * (points / 6500),
                        child: points > 0
                            ? Image.asset(
                                'assets/levelTreeIcon.png',
                              )
                            : null),
                    Container(
                        width: 83,
                        height:
                            points > 6500 ? 107 * ((points - 6500) / 6500) : 0,
                        child: points > 6500
                            ? Image.asset(
                                'assets/levelTreeIcon.png',
                              )
                            : null),
                    Container(
                        width: 83,
                        height: points > 13000
                            ? 107 * ((points - 13000) / 6500)
                            : 0,
                        child: points > 6500
                            ? Image.asset(
                                'assets/levelTreeIcon.png',
                              )
                            : null),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.4 * 0.65, bottom: 4),
                child: Text(
                  "${numberWithComma(points)} pts",
                  style: TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 0.032 * width,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    backgroundColor: Color(0xffD3D3D3),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff31AC53)),
                    value: points > 20000
                        ? (points - 20000) / 50000
                        : points > 5000
                            ? (points - 5000) / 20000
                            : points / 5000,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
