import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_manager.dart';

class AppConstants {
  static const int splashDelay = 2;
  static const int sliderAnimationTime = 300;
  static Widget sizeVer(double height) {
    return SizedBox(
      height: height,
    );
  }

  static Widget sizeHor(double width) {
    return SizedBox(width: width);
  }

  static void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class FirebaseConst {
  static const String users = "users";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";
  static const String chats = "chats";
  static const String messages = "messages";
  static const String stories = "stories";
}
