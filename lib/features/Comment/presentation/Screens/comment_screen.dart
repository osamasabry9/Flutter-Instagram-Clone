import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app_entity.dart';
import '../../../Post/presentation/cubit/get_single_post/get_single_post_cubit.dart';
import '../../../user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../cubit/comment_cubit.dart';
import '../widgets/comment_main_widget.dart';
import '../../../../../app/di.dart' as di;

class CommentScreen extends StatelessWidget {
  final AppEntity appEntity;

  const CommentScreen({super.key , required this.appEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentCubit>(
          create: (context) => di.instance<CommentCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.instance<GetSingleUserCubit>(),
        ),
        BlocProvider<GetSinglePostCubit>(
          create: (context) => di.instance<GetSinglePostCubit>(),
        ),
      ],
      child: Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body:  CommentMainWidget(appEntity: appEntity),
    ));
  }
}
