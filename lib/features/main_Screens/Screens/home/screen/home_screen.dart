import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';

import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/no_posts_yet_widget.dart';
import '../widgets/single_post_card_widget.dart';
import '../../../../../app/di.dart' as di;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: BlocProvider<PostCubit>(
        create: (context) =>
            di.instance<PostCubit>()..getPosts(post: const PostEntity()),
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
                          create: (context) => di.instance<PostCubit>(),
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
    );
  }

}
