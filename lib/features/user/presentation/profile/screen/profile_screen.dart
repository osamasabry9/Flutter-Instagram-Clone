import 'package:flutter/material.dart';

import '../../../../../../core/utils/values_manager.dart';
import '../widgets/app_bar_profile_widget.dart';
import '../widgets/info_user_widget.dart';
import '../widgets/view_posts_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarProfileWidget( context),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoUserWidget(),
              const SizedBox(height: AppSize.s12),
              Text(
                "Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSize.s12),
              const Text(
                "The bio of user.",
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
