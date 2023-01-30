import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/widgets/main_button.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../../chat/presentation/pages/chat_details_screen.dart';
import '../../../domain/entities/user_entity.dart';
import '../cubit/user_cubit.dart';

class InfoUserWidget extends StatelessWidget {
  final UserEntity currentUser;
  final String currentUid;
  const InfoUserWidget(
      {super.key, required this.currentUser, required this.currentUid});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppSize.s90,
          height: AppSize.s90,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: imageProfileWidget(
                  imageUrl: currentUser.profileUrl,
                  image: currentUser.imageFile)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "${currentUser.totalPosts}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSize.s8),
                    Text(
                      "Posts",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(width: AppSize.s16),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.followersRoute,
                        arguments: currentUser);
                  },
                  child: Column(
                    children: [
                      Text(
                        "${currentUser.totalFollowers}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSize.s8),
                      Text(
                        "Followers",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.followingRoute,
                        arguments: currentUser);
                  },
                  child: Column(
                    children: [
                      Text(
                        "${currentUser.totalFollowing}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSize.s8),
                      Text(
                        "Following",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: AppSize.s12),
              ],
            ),
            currentUid == currentUser.uid
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainButton(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.05,
                        isBold: false,
                        title: currentUser.followers!.contains(currentUid)
                            ? "UnFollow"
                            : "Follow",
                        color: currentUser.followers!.contains(currentUid)
                            ? ColorManager.white.withOpacity(.4)
                            : ColorManager.primary,
                        onTap: () {
                          BlocProvider.of<UserCubit>(context)
                              .followUnFollowUser(
                                  user: UserEntity(
                                      uid: currentUid,
                                      otherUid: currentUser.uid));
                        },
                      ),
                      const SizedBox(width: AppSize.s8),
                      MainButton(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.05,
                        isBold: false,
                        title: "Message",
                        color: ColorManager.white.withOpacity(.4),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailsScreen(
                                senderId: currentUid,
                                receiverUser: currentUser,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }
}
