import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mirae/splash_screen.dart';
import 'package:provider/provider.dart';

import 'login/firebase_provider.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FirebaseProvider>(
              create: (_) => FirebaseProvider())
        ],
        child: GetMaterialApp(
          title: 'MIRAE',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            focusColor: Colors.white.withOpacity(0),
            hoverColor: Colors.white.withOpacity(0),
            highlightColor: Colors.white.withOpacity(0),
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
            ),
            splashColor: Colors.grey[700].withOpacity(0),
          ),
          home: SplashScreen(),
        ));
  }
}
