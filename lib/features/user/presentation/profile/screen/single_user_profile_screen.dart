import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/get_single_user/get_single_user_cubit.dart';

import '../../../../Post/presentation/cubit/post_cubit.dart';
import '../widgets/single_user_profile_main_widget.dart';

import '../../../../../app/di.dart' as di;

class SingleUserProfileScreen extends StatelessWidget {
  final String otherUserId;
  const SingleUserProfileScreen({
    super.key,
    required this.otherUserId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.instance<PostCubit>(),
        ),
        BlocProvider(
          create: (context) => di.instance<GetSingleUserCubit>(),
        ),
      ],
      child: SingleUserProfileMainWidget(
        otherUserId: otherUserId,
      ),
    );
  }
}
