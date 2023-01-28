import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../cubit/chat_cubit.dart';

class ChatDetailsWidget extends StatefulWidget {
  final String senderId;
  final UserEntity receiverUser;
  const ChatDetailsWidget(
      {super.key, required this.senderId, required this.receiverUser});

  @override
  State<ChatDetailsWidget> createState() => _ChatDetailsWidgetState();
}

class _ChatDetailsWidgetState extends State<ChatDetailsWidget> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMessages(
      senderId: widget.senderId,
      receiverId: widget.receiverUser.uid!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, chatState) {
        if (chatState is ChatLoaded) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (widget.senderId ==
                          chatState.messages[index].senderId) {
                        return buildMessage(
                          alignment: AlignmentDirectional.centerEnd,
                          bottomEnd: 0.0,
                          bottomStart: AppSize.s15,
                          color: ColorManager.primary,
                          message: chatState.messages[index].text!,
                        );
                      } else {
                        return buildMessage(
                          alignment: AlignmentDirectional.centerStart,
                          bottomEnd: AppSize.s15,
                          bottomStart: 0.0,
                          color: ColorManager.grey,
                          message: chatState.messages[index].text!,
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15.0,
                    ),
                    itemCount: chatState.messages.length,
                  ),
                ),
                _messageSection(receiverUser: widget.receiverUser),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Align buildMessage({
    required AlignmentGeometry alignment,
    required double bottomEnd,
    required double bottomStart,
    required Color color,
    required String message,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(bottomEnd),
            bottomStart: Radius.circular(bottomStart),
            topEnd: const Radius.circular(AppSize.s15),
            topStart: const Radius.circular(AppSize.s15),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(message, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  _messageSection({required UserEntity receiverUser}) {
    return Container(
      width: double.infinity,
      height: AppSize.s60,
      decoration: BoxDecoration(
          color: ColorManager.darkGrey,
          borderRadius: BorderRadius.circular(AppSize.s10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Row(
          children: [
            const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Send your message...",
                ),
              ),
            )),
            GestureDetector(
                onTap: () {
                  _createMessage(receiverUser);
                },
                child: const Icon(
                  Bootstrap.send,
                  color: ColorManager.primary,
                ))
          ],
        ),
      ),
    );
  }

  _createMessage(UserEntity receiverUser) {
    BlocProvider.of<ChatCubit>(context)
        .sendTextMessage(
      message: MessageEntity(
        senderId: widget.senderId,
        receiverId: receiverUser.uid,
        createAt: Timestamp.now(),
        text: _messageController.text,
      ),
    )
        .then((value) {
      setState(() {
        _messageController.clear();
      });
    });
  }
}
