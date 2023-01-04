import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';

AppBar appBarWidget() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: SvgPicture.asset(
      ImageAssets.icInstagram,
      color: ColorManager.white,
      height: AppSize.s32,
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: AppPadding.p12),
        child: Icon(
          Bootstrap.messenger,
          color: ColorManager.white,
        ),
      )
    ],
  );
}
