import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';

import '../../../../../core/widgets/like_animation_widget.dart';
import '../../../../auth/presentation/widgets/profile_widget.dart';

class SinglePostCardWidget extends StatefulWidget {
  const SinglePostCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  bool _isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: profileWidget(imageUrl: ""),
                      ),
                    ),
                    AppConstants.sizeHor(AppSize.s12),
                    const Text(
                      "username",
                      style: TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _openBottomModalSheet(context);
                },
                child: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          AppConstants.sizeVer(AppSize.s12),
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Image(
                    image: NetworkImage(
                      'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
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
                        child: const Icon(
                          Icons.favorite_outline,
                          size: AppSize.s25,
                        )),
                    AppConstants.sizeHor(AppSize.s14),
                    GestureDetector(
                        onTap: () {},
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
          const Text(
            "total Likes",
            style: TextStyle(
                color: ColorManager.white, fontWeight: FontWeight.bold),
          ),
          AppConstants.sizeVer(AppSize.s12),
          Row(
            children: [
              const Text(
                "post.username",
                style: TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
              AppConstants.sizeHor(AppSize.s12),
              const Text(
                "post.description",
                style: TextStyle(color: ColorManager.white),
              ),
            ],
          ),
          AppConstants.sizeVer(AppSize.s12),
          GestureDetector(
              onTap: () {},
              child: const Text(
                "View all  comments",
                style: TextStyle(color: ColorManager.grey),
              )),
          AppConstants.sizeHor(AppSize.s12),
          const Text(
            "22/22/2022",
            style: TextStyle(color: ColorManager.grey),
          ),
        ],
      ),
    );
  }

  _openBottomModalSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration:
                BoxDecoration(color: ColorManager.black.withOpacity(.8)),
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
                      color: ColorManager.darkGrey,
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
                      color: ColorManager.darkGrey,
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
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

  _deletePost() {}

  _likePost() {}
}
