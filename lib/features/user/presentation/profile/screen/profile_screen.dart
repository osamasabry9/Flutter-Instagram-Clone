import 'package:flutter/material.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

import '../../../../../../core/utils/values_manager.dart';
import '../widgets/app_bar_profile_widget.dart';
import '../widgets/info_user_widget.dart';
import '../widgets/view_posts_widget.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity currentUser;
  const ProfileScreen({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarProfileWidget(context, currentUser),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoUserWidget(currentUser: currentUser),
              const SizedBox(height: AppSize.s12),
              Text(
                "${currentUser.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                "${currentUser.bio}",
              ),
              const SizedBox(height: AppSize.s20),
              const ViewPostsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
