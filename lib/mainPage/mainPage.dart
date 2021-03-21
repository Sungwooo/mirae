import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mirae/article/article.dart';
import 'package:mirae/home/home_page.dart';
import 'package:mirae/map/map.dart';
import 'package:mirae/profile/profile.dart';
import 'package:mirae/ranking/ranking-page.dart';

import '../camera/camera.dart';
import 'controller/nav_controller.dart';

_MainPageState pageState;

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  MainPage(this.cameras);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NavController navController = Get.put(NavController());

  final List<Widget> bodyContent = [
    HomePage(),
    RankingPage(),
    Text("Camera.."),
    ArticlePage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(
        () => Center(
          child: bodyContent.elementAt(navController.selectedIndex),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Color(0xff8F8F8F),
          selectedItemColor: Color(0xff31AC53),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              fontSize: 0.024 * width,
              fontWeight: FontWeight.w700,
              fontFamily: "GoogleSans"),
          unselectedLabelStyle: TextStyle(
              fontSize: 0.024 * width,
              fontWeight: FontWeight.w400,
              fontFamily: "GoogleSans"),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icon/bottomNavigation/home.png",
                width: 30,
              ),
              activeIcon: Image.asset(
                  "assets/icon/bottomNavigation/homeSelected.png",
                  width: 33),
              label: "Home",
              tooltip: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icon/bottomNavigation/worldMap.png",
                  width: 30),
              activeIcon: Image.asset(
                  "assets/icon/bottomNavigation/mapSelected.png",
                  width: 33),
              label: "Map",
              tooltip: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/icon/bottomNavigation/cameraIcon.png",
                  width: 60,
                ),
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              ),
              label: "",
              tooltip: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icon/bottomNavigation/article.png",
                  width: 30),
              activeIcon: Image.asset(
                  "assets/icon/bottomNavigation/articleSelected.png",
                  width: 33),
              label: "News",
              tooltip: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icon/bottomNavigation/profile.png",
                  width: 30),
              activeIcon: Image.asset(
                  "assets/icon/bottomNavigation/profileSelected.png",
                  width: 33),
              label: "My",
              tooltip: "",
            ),
          ],
          currentIndex: navController.selectedIndex,
          onTap: (index) => index == 2
              ? Get.to(() => CameraPage(widget.cameras))
              : navController.selectedIndex = index,
        ),
      ),
    );
  }
}
