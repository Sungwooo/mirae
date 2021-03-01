import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app/camera.dart';
import 'package:flutter_app/constants/material_color.dart';
import 'package:flutter_app/trash-info-page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  const MyApp({
    Key key,
    @required this.firstCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: TrashInfo(),
      // home: Camera(camera: firstCamera),
    );
  }
}