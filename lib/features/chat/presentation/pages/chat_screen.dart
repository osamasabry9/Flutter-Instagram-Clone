import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram_clone/core/utils/constants_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';
import 'package:instagram_clone/features/user/presentation/profile/cubit/user_cubit.dart';

import '../../../../../app/di.dart' as di;
import '../../../main_Screens/Screens/home/widgets/app_bar_widget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/usecases/get_current_uid_usecase.dart';
import '../widgets/build_chat_item_widget.dart';
import '../widgets/no_chats_yet_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _currentUid = "";

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: const UserEntity());
    di.instance<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              appBarRowWidget(context),
              Expanded(
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (userState is UserFailure) {
                      AppConstants.toast(
                          "Some Failure occurred while creating the GetMyChat");
                    }
                    if (userState is UserLoaded) {
                      final filterAllUsers = userState.users
                          .where((user) => !user.uid!.startsWith(_currentUid))
                          .toList();
                      return filterAllUsers.isEmpty
                          ? const NoChatsYetWidget()
                          : ListView.builder(
                              itemCount: filterAllUsers.length,
                              itemBuilder: (context, index) {
                                final singleChat = filterAllUsers[index];
                                return BlocProvider(
                                  create: (context) => di.instance<UserCubit>(),
                                  child: BuildChatItem(
                                      singleChat: singleChat,
                                      currentUid: _currentUid),
                                );
                              },
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
