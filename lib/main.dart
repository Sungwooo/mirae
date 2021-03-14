import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'article/article.dart';
import 'constants/material_color.dart';
import 'login/auth_page.dart';
import 'login/firebase_provider.dart';
import 'login/loginpage.dart';
import 'login/loginpage.dart';
import 'login/sign_in.dart';

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

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FirebaseProvider>( create: (_) => FirebaseProvider())
        ],
        child: GetMaterialApp(title: 'MIRAE',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: white,
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0.0,
              ),
              splashColor: Colors.grey[700],
            ),
            home: AuthPage(),
        )
    );
  }
}
