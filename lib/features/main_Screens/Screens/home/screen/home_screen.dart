import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/color_manager.dart';

import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/values_manager.dart';

import '../../../../../core/utils/routes_manager.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../../../../stroy/presentation/widgets/story_data.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../../user/presentation/profile/cubit/user_cubit.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/no_posts_yet_widget.dart';
import '../widgets/single_post_card_widget.dart';
import '../../../../../app/di.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.currentUser});

  final UserEntity currentUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: const UserEntity());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarRowWidget(context),
                storyWidget(context),
                BlocProvider<PostCubit>(
                  create: (context) => di.instance<PostCubit>()
                    ..getPosts(post: const PostEntity()),
                  child: BlocBuilder<PostCubit, PostState>(
                    builder: (context, postState) {
                      if (postState is PostLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (postState is PostFailure) {
                        AppConstants.toast(
                            "Some Failure occurred while creating the post");
                      }
                      if (postState is PostLoaded) {
                        return postState.posts.isEmpty
                            ? const NoPostsYetWidget()
                            : ListView.builder(
                                itemCount: postState.posts.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final post = postState.posts[index];
                                  return BlocProvider(
                                    create: (context) =>
                                        di.instance<PostCubit>(),
                                    child: SinglePostCardWidget(post: post),
                                  );
                                },
                              );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget storyWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p14),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (userState is UserFailure) {
            AppConstants.toast(
                "Some Failure occurred while creating the GetMyChat");
          }
          if (userState is UserLoaded) {
            
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: userState.users.length,
              itemBuilder: (context, index) =>
                  itemUserStory(context, userState.users[index]),
              separatorBuilder: (context, index) => const SizedBox(
                width: AppSize.s8,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  GestureDetector itemUserStory(BuildContext context, UserEntity user) {
    return GestureDetector(
      onTap: () => user.uid != widget.currentUser.uid
          ? Navigator.pushNamed(
              context,
              Routes.storyRoute,
            )
          : null,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: AppSize.s32,
                backgroundColor: user.uid != widget.currentUser.uid
                    ? ColorManager.error
                    : null,
                child: CircleAvatar(
                    radius: AppSize.s30,
                    backgroundImage: NetworkImage("${user.profileUrl}")),
              ),
              if (user.uid == widget.currentUser.uid)
                const CircleAvatar(
                  radius: 16.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
            user.uid != widget.currentUser.uid
                ? "${user.username}"
                : "Your story",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorManager.white),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
