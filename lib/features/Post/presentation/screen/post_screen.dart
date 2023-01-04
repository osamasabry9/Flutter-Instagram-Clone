import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppSize.s160,
        height: AppSize.s160,
        decoration: const BoxDecoration(
          color: ColorManager.darkGrey,
          shape: BoxShape.circle,
        ),
        child: const Center(
            child: Icon(
          Icons.upload,
          size: AppSize.s40,
          color: ColorManager.white,
        )),
      ),
    );
  }
}
