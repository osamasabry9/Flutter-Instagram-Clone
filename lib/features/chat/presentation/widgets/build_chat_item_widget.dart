import 'package:flutter/material.dart';
import '../pages/chat_details_screen.dart';

import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../user/domain/entities/user_entity.dart';

class BuildChatItem extends StatelessWidget {
  const BuildChatItem({
    super.key,
    required this.singleChat,
    required this.currentUid,
  });

  final UserEntity singleChat;
  final String currentUid;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
              senderId: currentUid,
              receiverUser: singleChat,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.s50,
              height: AppSize.s50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s25),
                child: imageProfileWidget(imageUrl: "${singleChat.profileUrl}"),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              singleChat.name!,
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
