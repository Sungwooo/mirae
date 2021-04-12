import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mirae/global.dart';
import 'package:mirae/home/controller/challenge_controller.dart';
import 'package:mirae/ranking/ranking-page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../mainPage/mainPage.dart';
import 'firebase_provider.dart';
import 'loginpage.dart';

AuthPageState pageState;

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() {
    pageState = AuthPageState();
    return pageState;
  }
}

class AuthPageState extends State<AuthPage> {
  final databaseReference = FirebaseDatabase.instance.reference();

  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null) {
      Globals.changeUid(fp.getUser().uid);
      searchData();
      setToday();
      setTodayChallenges();
      setRankData();
      return MainPage(cameras);
    } else {
      return LogIn();
    }
  }

  // ignore: missing_return
  Future<bool> searchData() async {
    try {
      fp = Provider.of<FirebaseProvider>(context);
      databaseReference
          .child('user')
          .child(fp.getUser().uid)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          createData();
        }
      });
    } on Exception catch (e) {}
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  void createData() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("profile/${fp.getUser().uid}");
    File image = await getImageFileFromAssets('profileImage.png');

    StorageUploadTask storageUploadTask = storageReference.putFile(image);

    await storageUploadTask.onComplete;
    await databaseReference.child('user').child(fp.getUser().uid).set({
      'name': fp.getUser().displayName,
      'country': 'US',
      'discard': 0,
      'distance': 0,
      'point': 0,
      'ping': 0,
      'ImageUrl': fp.getUser().photoUrl != null
          ? fp.getUser().photoUrl
          : '${(await storageReference.getDownloadURL()).toString()}'
    });
  }

  void setRankData() async {
    List<RankerType> rankerList = [];
    await databaseReference
        .child('user')
        .once()
        .then((values) => values.value.forEach(
              (key, values) {
                rankerList.add(RankerType(
                    name: values["name"],
                    imageUrl: values["ImageUrl"],
                    flag: values["country"],
                    discardCount: values["discard"],
                    pingCount: values["ping"],
                    points: values["point"],
                    uid: key));
              },
            ));
    await Globals.changeRankerList(rankerList);
    await Globals.sortRankerList();
    Globals.rankerList.asMap().forEach((index, value) => {
          if (value.uid == Globals.uid) {Globals.changeRank(index + 1)}
        });
  }

  void setToday() async {
    int today = fp != null
        ? DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .difference(fp.getUser().metadata.creationTime)
                .inDays +
            1
        : 5;
    await Globals.changeToday(today);
  }

  void setTodayChallenges() async {
    var challengeList = [0, 0, 0];
    final ChallengeController challengeController =
        Get.put(ChallengeController());
    await databaseReference
        .child('userChallenges')
        .child(Globals.uid)
        .once()
        .then((values) => values.value.forEach(
              (key, values) {
                print("key!");
                if (key == Globals.today.toString()) {
                  challengeList[0] = values[0];
                  challengeList[1] = values[1];
                  challengeList[2] = values[2];
                }
              },
            ));

    if (challengeList[0] == 1) {
      challengeController.checkedValue = 1;
    }
    if (challengeList[1] == 1) {
      challengeController.checkedValue = 2;
    }
    if (challengeList[2] == 1) {
      challengeController.checkedValue = 3;
    }
  }
}
