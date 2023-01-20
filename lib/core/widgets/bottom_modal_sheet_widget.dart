import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/constants_manager.dart';
import '../utils/values_manager.dart';

openBottomModalSheetWidget(
  BuildContext context, {
  required String title1,
  required String title2,
  required VoidCallback onTap1,
  required VoidCallback onTap2,
}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration:
              BoxDecoration(color: ColorManager.darkGrey.withOpacity(.8)),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "More Options",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 1,
                    color: ColorManager.black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: onTap1,
                      child: Text(
                        title1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorManager.white),
                      ),
                    ),
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                  const Divider(
                    thickness: 1,
                    color: ColorManager.black,
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: onTap2,
                      child: Text(
                        title2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorManager.white),
                      ),
                    ),
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                ],
              ),
            ),
          ),
        );
      });
}
