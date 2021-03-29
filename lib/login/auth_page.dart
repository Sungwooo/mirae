import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirae/global.dart';
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
  final databaseReference = FirebaseDatabase.instance.reference().child('user');

  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);

    if (fp.getUser() != null) {
      Globals.changeUid(fp.getUser().uid);
      searchData();
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
    await databaseReference.child(fp.getUser().uid).set({
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
}
