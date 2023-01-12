import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/utils/color_manager.dart';
import '../Post/presentation/screen/post_screen.dart';
import '../profile/presentation/screen/profile_screen.dart';
import 'Screens/activity/screen/activity_screen.dart';
import 'Screens/home/screen/home_screen.dart';
import 'Screens/search/screen/search_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;

  int _currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: ColorManager.black,
        activeColor: ColorManager.white,
        inactiveColor: ColorManager.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Bootstrap.house_fill), label: ""),
          BottomNavigationBarItem(icon: Icon(Bootstrap.search), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Bootstrap.plus_circle_fill), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: ""),
        ],
        onTap: navigationTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeScreen(),
          SearchScreen(),
          PostScreen(),
          ActivityScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
