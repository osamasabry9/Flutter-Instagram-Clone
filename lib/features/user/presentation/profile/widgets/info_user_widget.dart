import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/values_manager.dart';

class InfoUserWidget extends StatelessWidget {
  const InfoUserWidget({super.key});

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
                child: Image.asset(
                  ImageAssets.profileDefault,
                  fit: BoxFit.cover,
                ),
              ),
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
                  "0",
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
                  "88",
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
                  "5",
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
