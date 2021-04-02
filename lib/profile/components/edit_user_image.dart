import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../login/firebase_provider.dart';

Future<String> downloadURL(String uid) async {
  StorageReference ref = FirebaseStorage.instance.ref().child("profile/$uid");

  String url = (await ref.getDownloadURL()).toString();

  return url;
}

class EditImageNameWidget extends StatefulWidget {
  @override
  _EditImageNameWidgetState createState() => _EditImageNameWidgetState();
}

class _EditImageNameWidgetState extends State<EditImageNameWidget> {
  FirebaseProvider fp;
  FirebaseUser _user;
  final databaseReference = FirebaseDatabase.instance.reference().child('user');

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    _user = fp.getUser();
    return FutureBuilder(
        future: downloadURL(_user.uid),
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
            return InkWell(
              onTap: () {
                _uploadImageToStorage(ImageSource.gallery);
              },
              child: CircleAvatar(
                radius: width * 0.12,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: (width * 0.12) - 2,
                  backgroundImage: url != null
                      ? NetworkImage('$url', scale: 2)
                      : AssetImage('assets/profileImage.png'),
                ),
              ),
            );
          }
        });
  }

  void _uploadImageToStorage(ImageSource source) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;

    StorageReference storageReference =
        _firebaseStorage.ref().child("profile/${_user.uid}");

    StorageUploadTask storageUploadTask = storageReference.putFile(image);

    await storageUploadTask.onComplete;

    String downloadURL = (await storageReference.getDownloadURL()).toString();

    fp.changePhotoUrl(downloadURL);
    databaseReference.child(fp.getUser().uid).update({
      'ImageUrl': downloadURL != null ? '$downloadURL' : fp.getUser().photoUrl
    });
  }
}
