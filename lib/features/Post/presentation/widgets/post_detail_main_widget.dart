import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';
import 'package:intl/intl.dart';

import '../../../../../app/di.dart' as di;
import '../../../../app/app_entity.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../../core/widgets/like_animation_widget.dart';
import '../../../user/domain/usecases/get_current_uid_usecase.dart';
import '../../domain/entities/post_entity.dart';
import '../cubit/get_single_post/get_single_post_cubit.dart';
import '../cubit/post_cubit.dart';

class PostDetailMainWidget extends StatefulWidget {
  final String postId;
  const PostDetailMainWidget({Key? key, required this.postId})
      : super(key: key);

  @override
  State<PostDetailMainWidget> createState() => _PostDetailMainWidgetState();
}

class _PostDetailMainWidgetState extends State<PostDetailMainWidget> {
  String _currentUid = "";

  @override
  void initState() {
    BlocProvider.of<GetSinglePostCubit>(context)
        .getSinglePost(postId: widget.postId);

    di.instance<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
      ),
      body: BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
        builder: (context, getSinglePostState) {
          if (getSinglePostState is GetSinglePostLoaded) {
            final singlePost = getSinglePostState.post;
            return Padding(
              padding: const EdgeInsets.all(AppSize.s10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: AppSize.s30,
                              height: AppSize.s30,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s15),
                                child: imageProfileWidget(
                                    imageUrl: "${singlePost.userProfileUrl}"),
                              ),
                            ),
                            AppConstants.sizeHor(AppSize.s12),
                            Text(
                              "${singlePost.username}",
                              style: const TextStyle(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      singlePost.creatorUid == _currentUid
                          ? GestureDetector(
                              onTap: () {
                                _openBottomModalSheet(context, singlePost);
                              },
                              child: const Icon(
                                Icons.more_vert,
                              ),
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                  AppConstants.sizeVer(AppSize.s4),
                  GestureDetector(
                    onDoubleTap: () {
                      _likePost();
                      setState(() {
                        _isLikeAnimating = true;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: imageProfileWidget(
                              imageUrl: "${singlePost.postImageUrl}"),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _isLikeAnimating ? 1 : 0,
                          child: LikeAnimationWidget(
                              duration: const Duration(milliseconds: 200),
                              isLikeAnimating: _isLikeAnimating,
                              onLikeFinish: () {
                                setState(() {
                                  _isLikeAnimating = false;
                                });
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 100,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p10,
                      horizontal: AppPadding.p2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _likePost,
                              child: Icon(
                                singlePost.likes!.contains(_currentUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: singlePost.likes!.contains(_currentUid)
                                    ? ColorManager.error
                                    : ColorManager.white,
                              ),
                            ),
                            AppConstants.sizeHor(AppSize.s14),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.commentRoute,
                                      arguments: AppEntity(
                                          uid: _currentUid,
                                          postId: singlePost.postId));
                                },
                                child: const Icon(
                                  Bootstrap.chat,
                                  size: AppSize.s25,
                                )),
                            AppConstants.sizeHor(AppSize.s14),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Bootstrap.send,
                                size: AppSize.s25,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.bookmark_border,
                            size: AppSize.s25,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "${singlePost.totalLikes} likes",
                    style: const TextStyle(
                        color: ColorManager.white, fontWeight: FontWeight.bold),
                  ),
                  AppConstants.sizeVer(AppSize.s4),
                  Row(
                    children: [
                      Text(
                        "${singlePost.username}",
                        style: const TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold),
                      ),
                      AppConstants.sizeHor(AppSize.s12),
                      Text(
                        "${singlePost.description}",
                        style: const TextStyle(color: ColorManager.white),
                      ),
                    ],
                  ),
                  AppConstants.sizeVer(AppSize.s4),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.commentRoute,
                            arguments: AppEntity(
                                uid: _currentUid, postId: singlePost.postId));
                      },
                      child: Text(
                        "View all ${singlePost.totalComments} comments",
                        style: const TextStyle(color: ColorManager.grey),
                      )),
                  AppConstants.sizeVer(AppSize.s4),
                  Text(
                    DateFormat("dd/MMM/yyy")
                        .format(singlePost.createAt!.toDate()),
                    style: const TextStyle(color: ColorManager.grey),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _openBottomModalSheet(
    BuildContext context,
    final PostEntity post,
  ) {
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
                        onTap: _deletePost,
                        child: const Text(
                          "Delete Post",
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
                          Navigator.pushNamed(context, Routes.updatePostRoute,
                              arguments: post);
                        },
                        child: const Text(
                          "Update Post",
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

  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(post: PostEntity(postId: widget.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.postId));
  }
}
