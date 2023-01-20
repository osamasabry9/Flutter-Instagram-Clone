import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/values_manager.dart';
import '../../../../Post/domain/entities/post_entity.dart';
import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../cubit/get_single_other_user/get_single_other_user_cubit.dart';
import '../widgets/app_bar_profile_widget.dart';
import '../widgets/info_user_widget.dart';
import '../widgets/view_posts_widget.dart';
import '../../../../../app/di.dart' as di;

class SingleUserProfileMainWidget extends StatefulWidget {
  final String otherUserId;
  const SingleUserProfileMainWidget({
    super.key,
    required this.otherUserId,
  });

  @override
  State<SingleUserProfileMainWidget> createState() =>
      _SingleUserProfileMainWidgetState();
}

class _SingleUserProfileMainWidgetState
    extends State<SingleUserProfileMainWidget> {
  String currentUid = "";

  @override
  void initState() {
    BlocProvider.of<GetSingleOtherUserCubit>(context)
        .getSingleOtherUser(otherUid: widget.otherUserId);
    BlocProvider.of<PostCubit>(context).getPosts(post: const PostEntity());
    super.initState();

    di.instance<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        currentUid = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
      builder: (context, userState) {
        if (userState is GetSingleOtherUserLoaded) {
          final singleUser = userState.otherUser;
          return Scaffold(
            appBar:
                appBarProfileWidget(context, singleUser, isYourProfile: true),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoUserWidget(currentUser: singleUser ,currentUid : currentUid),
                    const SizedBox(height: AppSize.s12),
                    Text(
                      "${singleUser.name}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSize.s12),
                    Text(
                      "${singleUser.bio}",
                    ),
                    const SizedBox(height: AppSize.s20),
                    ViewPostsWidget(userId: singleUser.uid!),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
