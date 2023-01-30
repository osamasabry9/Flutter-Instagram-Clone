import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../../../core/widgets/input_field.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../../user/presentation/profile/cubit/user_cubit.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: const UserEntity());
    BlocProvider.of<PostCubit>(context).getPosts(post: const PostEntity());
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            final filterAllUsers = userState.users
                .where((user) =>
                    user.username!.startsWith(_searchController.text) ||
                    user.username!
                        .toLowerCase()
                        .startsWith(_searchController.text.toLowerCase()) ||
                    user.username!.contains(_searchController.text) ||
                    user.username!
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                .toList();
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    textController: _searchController,
                    label: "Search",
                    hint: "Search",
                    prefix: Icons.search,
                    validate: (p0) {
                      return null;
                    },
                  ),
                  AppConstants.sizeVer(AppSize.s20),
                  _searchController.text.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: filterAllUsers.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.singleUserProfileRoute,
                                        arguments: filterAllUsers[index].uid);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: AppMargin.m12),
                                        width: AppSize.s40,
                                        height: AppSize.s40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s20),
                                          child: imageProfileWidget(
                                              imageUrl: filterAllUsers[index]
                                                  .profileUrl),
                                        ),
                                      ),
                                      AppConstants.sizeHor(AppSize.s12),
                                      Text(
                                        "${filterAllUsers[index].username}",
                                        style: const TextStyle(
                                            color: ColorManager.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child: BlocBuilder<PostCubit, PostState>(
                            builder: (context, postState) {
                              if (postState is PostLoaded) {
                                final post = postState.posts;
                                return GridView.builder(
                                  itemCount: post.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.postDetailRoute,
                                            arguments: post[index].postId);
                                      },
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: imageProfileWidget(
                                            imageUrl: post[index].postImageUrl),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: ColorManager.primary),
                              );
                            },
                          ),
                        )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        },
      ),
    );
  }
}
