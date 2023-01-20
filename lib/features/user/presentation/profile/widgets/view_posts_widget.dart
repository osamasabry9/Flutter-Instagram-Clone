import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/routes_manager.dart';
import 'package:instagram_clone/features/Post/presentation/cubit/post_cubit.dart';
import '../../../../../core/widgets/image_profile_widget.dart';

class ViewPostsWidget extends StatelessWidget {
  final String userId;
  const ViewPostsWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, postState) {
        if (postState is PostLoaded) {
          final posts = postState.posts
              .where((post) => post.creatorUid == userId)
              .toList();
          return GridView.builder(
              itemCount: posts.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.postDetailRoute,
                        arguments: posts[index].postId);
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child:
                        imageProfileWidget(imageUrl: posts[index].postImageUrl),
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
