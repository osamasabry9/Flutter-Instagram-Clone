import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app/di.dart' as di;
import '../../../../app/app_entity.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../Post/domain/entities/post_entity.dart';
import '../../../Post/presentation/cubit/get_single_post/get_single_post_cubit.dart';
import '../../../replay/presentation/cubit/replay_cubit.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../../domain/entities/comment_entity.dart';
import '../cubit/comment_cubit.dart';
import 'single_comment_widget.dart';

class CommentMainWidget extends StatefulWidget {
  final AppEntity appEntity;
  const CommentMainWidget({super.key, required this.appEntity});

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(uid: widget.appEntity.uid!);

    BlocProvider.of<GetSinglePostCubit>(context)
        .getSinglePost(postId: widget.appEntity.postId!);

    BlocProvider.of<CommentCubit>(context)
        .getComments(postId: widget.appEntity.postId!);

    super.initState();
  }

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, singleUserState) {
        if (singleUserState is GetSingleUserLoaded) {
          final singleUser = singleUserState.user;
          return BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
            builder: (context, singlePostState) {
              if (singlePostState is GetSinglePostLoaded) {
                final singlePost = singlePostState.post;
                return BlocBuilder<CommentCubit, CommentState>(
                  builder: (context, commentState) {
                    if (commentState is CommentLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoPostSection(currentPost: singlePost),
                          const Divider(
                            color: ColorManager.grey,
                          ),
                          AppConstants.sizeVer(AppSize.s12),
                          Expanded(
                            child: ListView.builder(
                                itemCount: commentState.comments.length,
                                itemBuilder: (context, index) {
                                  final singleComment =
                                      commentState.comments[index];
                                  return BlocProvider(
                                    create: (context) =>
                                        di.instance<ReplayCubit>(),
                                    child: SingleCommentWidget(
                                      currentUser: singleUser,
                                      comment: singleComment,
                                      onLongPressListener: () {
                                        _openBottomModalSheet(
                                          context: context,
                                          comment: commentState.comments[index],
                                        );
                                      },
                                      onLikeClickListener: () {
                                        _likeComment(
                                            comment:
                                                commentState.comments[index]);
                                      },
                                    ),
                                  );
                                }),
                          ),
                          _commentSection(currentUser: singleUser)
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _infoPostSection({required PostEntity currentPost}) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    child: imageProfileWidget(
                        imageUrl: currentPost.userProfileUrl),
                  ),
                ),
                AppConstants.sizeHor(AppSize.s12),
                Text(
                  "${currentPost.username}",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.white),
                )
              ],
            ),
          ),
          AppConstants.sizeVer(AppSize.s12),
          Text(
            "${currentPost.description}",
            style: const TextStyle(color: ColorManager.white),
          ),
          AppConstants.sizeVer(AppSize.s12),
        ],
      ),
    );
  }

  _commentSection({required UserEntity currentUser}) {
    return Container(
      width: double.infinity,
      height: AppSize.s60,
      color: ColorManager.darkGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.s40,
              height: AppSize.s40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: imageProfileWidget(imageUrl: ""),
              ),
            ),
            AppConstants.sizeHor(AppSize.s10),
            Expanded(
                child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Post your comment...",
              ),
            )),
            GestureDetector(
                onTap: () {
                  _createComment(currentUser);
                },
                child: Text(
                  "Post",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.primary),
                ))
          ],
        ),
      ),
    );
  }

  _createComment(UserEntity currentUser) {
    BlocProvider.of<CommentCubit>(context)
        .createComment(
            comment: CommentEntity(
      totalReplays: 0,
      commentId: const Uuid().v1(),
      createAt: Timestamp.now(),
      likes: const [],
      username: currentUser.username,
      userProfileUrl: currentUser.profileUrl,
      description: _descriptionController.text,
      creatorUid: currentUser.uid,
      postId: widget.appEntity.postId,
    ))
        .then((value) {
      setState(() {
        _descriptionController.clear();
      });
    });
  }

  _openBottomModalSheet(
      {required BuildContext context, required CommentEntity comment}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration:
                BoxDecoration(color: ColorManager.darkGrey.withOpacity(.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorManager.white),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: ColorManager.black,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _deleteComment(
                              commentId: comment.commentId!,
                              postId: comment.postId!);
                        },
                        child: const Text(
                          "Delete Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorManager.white),
                        ),
                      ),
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                    const Divider(
                      thickness: 1,
                      color: ColorManager.black,
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                                  context, Routes.uploadCommentRoute,
                                  arguments: comment)
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text(
                          "Update Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorManager.white),
                        ),
                      ),
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteComment({required String commentId, required String postId}) {
    BlocProvider.of<CommentCubit>(context)
        .deleteComment(
            comment: CommentEntity(commentId: commentId, postId: postId))
        .then((value) => Navigator.pop(context));
  }

  _likeComment({required CommentEntity comment}) {
    BlocProvider.of<CommentCubit>(context).likeComment(
        comment: CommentEntity(
            commentId: comment.commentId, postId: comment.postId));
  }
}
