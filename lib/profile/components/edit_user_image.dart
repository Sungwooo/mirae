import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../login/firebase_provider.dart';

class EditImageNameWidget extends StatefulWidget {
  @override
  _EditImageNameWidgetState createState() => _EditImageNameWidgetState();
}

class _EditImageNameWidgetState extends State<EditImageNameWidget> {

  FirebaseProvider fp;
  FirebaseUser _user;

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  void initState() {
    super.initState();
  }



  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    _user=fp.getUser();
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Column(children: [
          InkWell(
          onTap: () => _uploadImageToStorage(ImageSource.gallery),
              child: CircleAvatar(
                radius: width * 0.12,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: (width * 0.12) - 2,
                  backgroundImage:  (_user.photoUrl != null) ? NetworkImage(_user.photoUrl) : NetworkImage(""),
                ),
              ),
          ),
      ]),
    );
  }

  void _uploadImageToStorage(ImageSource source) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;

    StorageReference storageReference =
    _firebaseStorage.ref().child("profile/${_user.uid}");

    StorageUploadTask storageUploadTask = storageReference.putFile(image);

    String downloadURL = await storageReference.getDownloadURL().toString();
    print(downloadURL);
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.photoUrl=downloadURL;
    await _user.updateProfile(userUpdateInfo);

    await storageUploadTask.onComplete;

  }
}
