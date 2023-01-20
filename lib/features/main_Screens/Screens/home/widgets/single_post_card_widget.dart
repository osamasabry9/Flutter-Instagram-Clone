import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../app/app_entity.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/bottom_modal_sheet_widget.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../../../core/widgets/like_animation_widget.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import 'package:intl/intl.dart';
import '../../../../../app/di.dart' as di;
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../../../../user/domain/usecases/get_current_uid_usecase.dart';

class SinglePostCardWidget extends StatefulWidget {
  final PostEntity post;
  const SinglePostCardWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  String _currentUid = "";

  @override
  void initState() {
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
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.singleUserProfileRoute,
                    arguments: widget.post.creatorUid,
                  );
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: AppSize.s30,
                      height: AppSize.s30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s15),
                        child: imageProfileWidget(
                            imageUrl: "${widget.post.userProfileUrl}"),
                      ),
                    ),
                    AppConstants.sizeHor(AppSize.s12),
                    Text(
                      "${widget.post.username}",
                      style: const TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              widget.post.creatorUid == _currentUid
                  ? GestureDetector(
                      onTap: () {
                        openBottomModalSheetWidget(
                          context,
                          title1: "Delete Post",
                          onTap1: _deletePost,
                          title2: "Update Post",
                          onTap2: () {
                            Navigator.pushNamed(context, Routes.updatePostRoute,
                                    arguments: widget.post)
                                .then((value) => Navigator.pop(context));
                          },
                        );
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
                      imageUrl: "${widget.post.postImageUrl}"),
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
                        widget.post.likes!.contains(_currentUid)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: widget.post.likes!.contains(_currentUid)
                            ? ColorManager.error
                            : ColorManager.white,
                      ),
                    ),
                    AppConstants.sizeHor(AppSize.s14),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.commentRoute,
                              arguments: AppEntity(
                                  uid: _currentUid,
                                  postId: widget.post.postId));
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
            "${widget.post.totalLikes} likes",
            style: const TextStyle(
                color: ColorManager.white, fontWeight: FontWeight.bold),
          ),
          AppConstants.sizeVer(AppSize.s4),
          Row(
            children: [
              Text(
                "${widget.post.username}",
                style: const TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
              AppConstants.sizeHor(AppSize.s12),
              Text(
                "${widget.post.description}",
                style: const TextStyle(color: ColorManager.white),
              ),
            ],
          ),
          AppConstants.sizeVer(AppSize.s4),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.commentRoute,
                    arguments: AppEntity(
                        uid: _currentUid, postId: widget.post.postId));
              },
              child: Text(
                "View all ${widget.post.totalComments} comments",
                style: const TextStyle(color: ColorManager.grey),
              )),
          AppConstants.sizeVer(AppSize.s4),
          Text(
            DateFormat("dd/MMM/yyy").format(widget.post.createAt!.toDate()),
            style: const TextStyle(color: ColorManager.grey),
          ),
        ],
      ),
    );
  }

  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(post: PostEntity(postId: widget.post.postId))
        .then((value) => Navigator.pop(context));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.post.postId));
  }
}
