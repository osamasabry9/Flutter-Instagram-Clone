import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';

import 'package:instagram_clone/core/utils/constants_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';

import '../../../../../core/utils/routes_manager.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/no_posts_yet_widget.dart';
import '../widgets/single_post_card_widget.dart';
import '../../../../../app/di.dart' as di;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.currentUser});

  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              appBarRowWidget(context),
              Container(
                height: MediaQuery.of(context).size.height * 0.16,
                width: double.infinity,
                padding: const EdgeInsets.all(AppPadding.p14),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => index != 0
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
                              backgroundColor:
                                  index != 0 ? ColorManager.error : null,
                              child: CircleAvatar(
                                radius: AppSize.s30,
                                backgroundImage:
                                    NetworkImage("${currentUser.profileUrl}"),
                              ),
                            ),
                            if (index == 0)
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
                          index != 0 ? "username" : "Your story",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: ColorManager.white),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: AppSize.s8,
                  ),
                ),
              ),
              Expanded(
                child: BlocProvider<PostCubit>(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
