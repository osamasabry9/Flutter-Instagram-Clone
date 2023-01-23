import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';

Row appBarRowWidget()
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: AppSize.s40,
        height: AppSize.s40,
        decoration: const BoxDecoration(
          color: ColorManager.backgroundContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s20),
          ),
        ),
        child: const Icon(
          Bootstrap.camera_fill,
          color: ColorManager.darkGrey,
          size: AppSize.s20,
        ),
      ),
      SvgPicture.asset(
        ImageAssets.icInstagram,
        color: ColorManager.backgroundContainer,
        height: AppSize.s32,
      ),
      Container(
        width: AppSize.s40,
        height: AppSize.s40,
        decoration: const BoxDecoration(
          color: ColorManager.backgroundContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.s20),
          ),
        ),
        child: const Icon(
          Bootstrap.messenger,
          color: ColorManager.darkGrey,
          size: AppSize.s20,
        ),
      ),
    ],
  );
}