import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../domain/entities/user_entity.dart';

class SingleUserWidget extends StatelessWidget {
  const SingleUserWidget({
    Key? key,
    required this.singleUserData,
  }) : super(key: key);

  final UserEntity singleUserData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, Routes.singleUserProfileRoute,
            arguments: singleUserData.uid);
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(
                AppSize.s10),
            width: AppSize.s50,
            height: AppSize.s50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s25),
              child: imageProfileWidget(
                  imageUrl:
                  singleUserData.profileUrl),
            ),
          ),
          AppConstants.sizeHor(AppSize.s20),
          Text(
            "${singleUserData.username}",
            style:Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}