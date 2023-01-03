import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s20),
        SvgPicture.asset(
          ImageAssets.icInstagram,
          height: AppSize.s100,
          color: ColorManager.white,
          width: double.infinity,
        ),
        const SizedBox(height: AppSize.s40),
      ],
    );
  }
}
