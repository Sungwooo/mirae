import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('NEWS', textAlign: TextAlign.center),
        ),
        body: Column(children: <Widget>[
          Container(
              color: Colors.lightGreenAccent,
              child: Row(children: [
                Container(
                    width: 70,
                    child: Image(image: AssetImage('assets/world.png'))),
                Container(
                    width: 178,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('E - Challenge',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.green,
                              value: true,
                            ),
                            Text('2',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ],
                    )),
                Row(children: [
                  Text('Day 1',
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                ]),
              ])),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Eco news',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.lightBlueAccent.withOpacity(0.6),
                        fontSize: 30)),
                Text('2021.02.22',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 14))
              ]),
          SizedBox(height: 10),
          Container(
              width: 350,
              height: 240,
              color: Colors.grey,
              /*decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/heart.png'),
              fit: BoxFit.cover,
            ),
            ),*/
              child: Text(
                  'UN hails ‘day of hope’ as US officially rejoins Paris climate accord',
                  style: TextStyle(color: Colors.white, fontSize: 24))),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Container(
                  width: 153,
                  height: 103,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/heart.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(children: [
                    Row(children: [
                      Text(
                          'UN chief to security\n meeting: ‘2021 must be\n the year to get back on\n track',
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                    ]),
                    Row(children: [
                      Text('Climate Change',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 12)),
                    ]),
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Container(
                  width: 153,
                  height: 103,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/heart.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Column(children: [
                    Row(children: [
                      Text(
                          'UN chief to security\n meeting: ‘2021 must be\n the year to get back on\n track',
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                    ]),
                    Row(children: [
                      Text('Climate Change',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 12)),
                    ]),
                  ]),
                ),
              ],
            ),
          ),
        ]));
  }
}
