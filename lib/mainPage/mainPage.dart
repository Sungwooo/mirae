import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mirae/article/article.dart';
import 'package:mirae/camera/trash_info.dart';
import 'package:mirae/home/home_page.dart';
import 'package:mirae/map/map.dart';
import 'package:mirae/profile/profile.dart';

import 'controller/nav_controller.dart';

class MainPage extends StatelessWidget {
  final NavController navController = Get.put(NavController());

  final List<Widget> bodyContent = [
    HomePage(),
    Text("Map..."),
    Text("Camera.."),
    ArticlePage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: bodyContent.elementAt(navController.selectedIndex),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: Color(0xff8F8F8F),
          selectedItemColor: Color(0xff31AC53),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              fontFamily: "GoogleSans"),
          unselectedLabelStyle: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w400,
              fontFamily: "GoogleSans"),
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage("assets/icon/bottomNavigation/home.png")),
              activeIcon: ImageIcon(
                  AssetImage("assets/icon/bottomNavigation/homeSelected.png")),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage("assets/icon/bottomNavigation/worldMap.png")),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/icon/bottomNavigation/cameraIcon.png",
                  width: 60,
                ),
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage("assets/icon/bottomNavigation/article.png")),
              activeIcon: ImageIcon(AssetImage(
                  "assets/icon/bottomNavigation/articleSelected.png")),
              label: "Article",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage("assets/icon/bottomNavigation/profile.png")),
              label: "My",
            ),
          ],
          currentIndex: navController.selectedIndex,
          onTap: (index) => index == 2
              ? Get.to(() => TrashInfo())
              : index == 1
                  ? Get.to(() => MapPage())
                  : navController.selectedIndex = index,
        ),
      ),
    );
  }
}
