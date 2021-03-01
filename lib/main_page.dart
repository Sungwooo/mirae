import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirae/trash_info.dart';

import 'camera.dart';
import 'home_page.dart';
import 'follow.dart';
import 'map.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  CameraDescription firstCamera;

  Future<void> getCameras() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MapPage(),
    Container(
      color: Colors.primaries[2],
    ),
    FollowPage(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    getCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Color(0xff8F8F8F),
        selectedItemColor: Color(0xff31AC53),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/icon/bottomNavigation/homeSelected.png",
              iconPath: "assets/icon/bottomNavigation/home.png"),
          _buildBottomNavigationBarItem(
              iconPath: "assets/icon/bottomNavigation/worldMap.png"),
          _buildBottomNavigationBarItem(iconPath: "assets/add.png"),
          _buildBottomNavigationBarItem(
              activeIconPath:
                  "assets/icon/bottomNavigation/articleSelected.png",
              iconPath: "assets/icon/bottomNavigation/article.png"),
          _buildBottomNavigationBarItem(
              iconPath: "assets/icon/bottomNavigation/profile.png"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath, String label}) {
    return BottomNavigationBarItem(
      activeIcon:
          activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      label: label,
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Get.to(() => TrashInfo());
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
