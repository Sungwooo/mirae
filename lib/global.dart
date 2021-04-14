import 'package:firebase_database/firebase_database.dart';
import 'package:mirae/ranking/ranking-page.dart';

class Globals {
  static int rank = 0;
  static int points = 0;
  static String uid = "";
  static List<RankerType> rankerList = [];
  static int today = 0;
  final dbRef = FirebaseDatabase.instance.reference();

  static changeRank(int a) {
    rank = a; // this can be replaced with any static method
  }

  static changePoints(int a) {
    points = a;
  }

  static changeUid(String a) {
    uid = a; // this can be replaced with any static method
  }

  static changeToday(int a) {
    today = a;
  }

  static changeRankerList(List<RankerType> li) {
    rankerList = [];
    rankerList = li;
  }

  static sortRankerList() {
    Comparator<RankerType> pointComparator =
        (a, b) => b.points.compareTo(a.points);
    rankerList.sort(pointComparator);
  }
}
