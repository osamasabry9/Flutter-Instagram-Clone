import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

import '../../../../../../core/utils/values_manager.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../widgets/app_bar_profile_widget.dart';
import '../widgets/info_user_widget.dart';
import '../widgets/view_posts_widget.dart';
import '../../../../../app/di.dart' as di;

class ProfileScreen extends StatelessWidget {
  final UserEntity currentUser;
  const ProfileScreen({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.instance<PostCubit>(),
      child: ProfileMainWidget(currentUser: currentUser),
    );
  }
}

class ProfileMainWidget extends StatefulWidget {
  const ProfileMainWidget({
    super.key,
    required this.currentUser,
  });

  final UserEntity currentUser;

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> {
  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts(post: const PostEntity());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarProfileWidget(context, widget.currentUser),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoUserWidget(
                  currentUser: widget.currentUser,
                  currentUid: widget.currentUser.uid!),
              const SizedBox(height: AppSize.s12),
              Text(
                "${widget.currentUser.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                "${widget.currentUser.bio}",
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: Divider(
                  color: ColorManager.grey,
                ),
              ),
              ViewPostsWidget(userId: widget.currentUser.uid!),
            ],
          ),
        ),
      ),
    );
  }
}
