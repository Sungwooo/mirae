import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mirae/login/firebase_provider.dart';

Future<String> downloadURL(String uid) async {
  StorageReference ref = FirebaseStorage.instance.ref().child("profile/$uid");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

// ignore: must_be_immutable
class MyImageWidget extends StatelessWidget {
  FirebaseProvider fp;

  MyImageWidget({this.fp});

  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = fp.getUser();
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: downloadURL(currentUser.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff36A257)),
                  )),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 0.04 * width),
              ),
            );
          } else {
            String url = snapshot.data;
            return CircleAvatar(
              radius: width * 0.12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: (width * 0.12) - 2,
                backgroundImage: url != null
                    ? NetworkImage('$url', scale: 2)
                    : AssetImage('assets/profileImage.png'),
              ),
            );
          }
        });
  }
}
