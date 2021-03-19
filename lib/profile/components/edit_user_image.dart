import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditImageNameWidget extends StatefulWidget {
  @override
  _EditImageNameWidgetState createState() => _EditImageNameWidgetState();
}

class _EditImageNameWidgetState extends State<EditImageNameWidget> {

  Image profileImage;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
    profileImage= (NetworkImage(_user.uid)) as Image;
  }


  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  backgroundImage:  (profileImage != null) ? profileImage : NetworkImage(""),
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

    String downloadURL = await storageReference.getDownloadURL();
    setState(() {
      _profileImageURL = downloadURL;
    });

    await storageUploadTask.onComplete;

  }
}
