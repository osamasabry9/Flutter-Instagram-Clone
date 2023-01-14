import 'package:flutter/material.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../domain/entities/user_entity.dart';

class InfoUserWidget extends StatelessWidget {
  final UserEntity currentUser;
  const InfoUserWidget({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            SizedBox(
              width: AppSize.s90,
              height: AppSize.s90,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: imageProfileWidget(image: currentUser.imageFile)),
            ),
            Positioned(
              right: -10,
              bottom: -15,
              child: IconButton(
                color: ColorManager.primary,
                onPressed: () {},
                icon: const Icon(
                  Icons.add_a_photo,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "${currentUser.totalPosts}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  "Posts",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(width: AppSize.s16),
            Column(
              children: [
                Text(
                  "${currentUser.totalFollowers}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  "Followers",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            const SizedBox(width: AppSize.s16),
            Column(
              children: [
                Text(
                  "${currentUser.totalFollowing}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  "Following",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            const SizedBox(width: AppSize.s12),
          ],
        ),
      ],
    );
  }
}
