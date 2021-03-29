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
            return CircleAvatar(
              radius: width * 0.12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: (width * 0.12) - 2,
                backgroundImage: AssetImage('assets/profileImage.png'),
              ),
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
                    : fp.getUser().photoUrl != null
                        ? NetworkImage(fp.getUser().photoUrl)
                        : AssetImage('assets/profileImage.png'),
              ),
            );
          }
        });
  }
}
