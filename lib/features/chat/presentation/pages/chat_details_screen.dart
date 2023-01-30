import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../app/di.dart' as di;
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/chat_details_widget.dart';

class ChatDetailsScreen extends StatelessWidget {
  final String senderId;
  final UserEntity receiverUser;
  const ChatDetailsScreen({
    super.key,
    required this.senderId,
    required this.receiverUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
        create: (context) => di.instance<ChatCubit>(),
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: ColorManager.darkGrey.withOpacity(0.5),
            title: Row(
              children: [
                SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    child:
                        imageProfileWidget(imageUrl: receiverUser.profileUrl),
                  ),
                ),
                AppConstants.sizeHor(AppSize.s12),
                Text(
                  "${receiverUser.username}",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.white),
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Bootstrap.camera_video),
              ),
            ],
          ),
          body: ChatDetailsWidget(
            senderId: senderId,
            receiverUser: receiverUser,
          ),
        ));
  }
}
