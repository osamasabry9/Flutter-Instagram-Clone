import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/utils/color_manager.dart';
import '../Post/presentation/screen/upload_post_screen.dart';
import '../user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../user/presentation/profile/screen/profile_screen.dart';
import 'Screens/activity/screen/activity_screen.dart';
import 'Screens/home/screen/home_screen.dart';
import 'Screens/search/screen/search_screen.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({
    Key? key,
    required this.uid,
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
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
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
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: ColorManager.black,
              activeColor: ColorManager.white,
              inactiveColor: ColorManager.grey,
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.house_fill), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.search), label: ""),
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
              children:  [
                const HomeScreen(),
                const SearchScreen(),
                 UploadPostScreen(currentUser: currentUser),
                const ActivityScreen(),
                ProfileScreen(currentUser: currentUser),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorManager.primary,
          ),
        );
      },
    );
  }
}
