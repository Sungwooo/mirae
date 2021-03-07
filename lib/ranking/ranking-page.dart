import 'package:flutter/material.dart';
import 'package:mirae/map/map.dart';

class RankerType {
  String name;
  String imageUrl;
  String flag;
  int points;
  int discardCount;
  int pingCount;

  RankerType(
      {this.name, this.imageUrl, this.flag, this.points, this.discardCount, this.pingCount});
}

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<RankerType> rankerList = new List();

  @override
  void initState() {
    super.initState();

    rankerList.add(RankerType(
        name: 'Mad Max',
        imageUrl: 'https://source.unsplash.com/Yui5vfKHuzs/640x404',
        flag: '',
        points: 1003009,
        discardCount: 512,
        pingCount: 1412));
    rankerList.add(RankerType(
        name: 'Mad Max',
        imageUrl: 'https://source.unsplash.com/Yui5vfKHuzs/640x404',
        flag: '',
        points: 1003009,
        discardCount: 512,
        pingCount: 1412));
    rankerList.add(RankerType(
        name: 'Mad Max',
        imageUrl: 'https://source.unsplash.com/Yui5vfKHuzs/640x404',
        flag: '',
        points: 1003009,
        discardCount: 512,
        pingCount: 1412));
    rankerList.add(RankerType(
        name: 'Mad Max',
        imageUrl: 'https://source.unsplash.com/Yui5vfKHuzs/640x404',
        flag: '',
        points: 1003009,
        discardCount: 512,
        pingCount: 1412));
    rankerList.add(RankerType(
        name: 'Mad Max',
        imageUrl: 'https://source.unsplash.com/Yui5vfKHuzs/640x404',
        flag: '',
        points: 1003009,
        discardCount: 512,
        pingCount: 1412));
  }

  Widget _renderProfile(BuildContext context, index) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            width: 60,
            height: 60,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(rankerList[index].imageUrl),
            ),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Color.fromRGBO(66, 178, 97, 1),
                width: 2.0,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(rankerList[index].name, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600)),
            Text("${rankerList[index].points} pts", style: TextStyle(color: Color.fromRGBO(66, 178, 97, 1), fontSize: 14, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }

  Widget _renderTypeItem(BuildContext context, index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: GestureDetector(onTap: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${index + 1}", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600)),
              _renderProfile(context, index),
              Image.asset('assets/ic_loc_discard.png', width: 56, height: 56),
              Text('${rankerList[index].discardCount}', style: TextStyle(color: Color.fromRGBO(66, 178, 97, 1), fontSize: 16, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600)),
              Image.asset('assets/ic_loc_ping.png', width: 56, height: 56),
              Text('${rankerList[index].pingCount}', style: TextStyle(color: Color.fromRGBO(244, 198, 35, 1), fontSize: 16, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600)),
            ],
          )
        ));
  }

  Widget _renderHeaderContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text('DISCARD', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600))
              ),
              Row(
                children: [
                  Image.asset('assets/ic_loc_discard.png', width: 60, height: 60),
                  Text('3050', style: TextStyle(color: Color.fromRGBO(66, 178, 97, 1), fontSize: 28, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text('PING', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600))
              ),
              Row(
                children: [
                  Image.asset('assets/ic_loc_ping.png', width: 60, height: 60),
                  Text('10208', style: TextStyle(color: Color.fromRGBO(244, 198, 35, 1), fontSize: 28, fontFamily: 'GoogleSans', fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _renderHandlinedTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      width: 250,
      child: Column(
        children: [
          Text("World Ranking",
              style: TextStyle(
                  fontSize: 28,
                  color: Color.fromRGBO(66, 178, 97, 1),
                  fontFamily: 'GoogleSans',
                  fontWeight: FontWeight.w600)),
          Image.asset('assets/handline_green.png', height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('MAP',
                style: TextStyle(
                    color: Color.fromRGBO(49, 172, 131, 1),
                    fontFamily: 'GoogleSans',
                    fontWeight: FontWeight.w600)),
            centerTitle: true),
        body: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPage()),
              ),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('assets/bg_ranking.png'),
                        fit: BoxFit.cover)),
                child: _renderHeaderContent(),
              ),
            ),
            _renderHandlinedTitle(),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: rankerList.length,
                  itemBuilder: (context, index) {
                    return _renderTypeItem(context, index);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
