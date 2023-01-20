import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/get_single_post/get_single_post_cubit.dart';
import '../cubit/post_cubit.dart';
import '../../../../../app/di.dart' as di;
import '../widgets/post_detail_main_widget.dart';


class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSinglePostCubit>(
          create: (context) => di.instance<GetSinglePostCubit>(),
        ),
        BlocProvider<PostCubit>(
          create: (context) => di.instance<PostCubit>(),
        ),
      ],
      child: PostDetailMainWidget(postId: postId),
    );
  }
}