import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: 0.009 * height),
      child: Container(
        height: 0.2 * height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06 * width),
          child: Column(
            children: [
              Container(
                height: 0.15 * height,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.4 * 0.65, bottom: 4),
                child: Text(
                  "10030 pts",
                  style: TextStyle(
                      fontFamily: "GoogleSans",
                      fontSize: 12,
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
                    value: 0.65,
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
