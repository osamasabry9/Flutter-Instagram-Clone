import 'package:flutter/material.dart';
import '../../../../../core/utils/values_manager.dart';

AppBar appBarProfileWidget() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text("User Name"),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: AppPadding.p12),
        child: Icon(
          Icons.menu,
        ),
      )
    ],
  );
}
