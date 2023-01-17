import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/entities/post_entity.dart';
import '../cubit/post_cubit.dart';
import '../widgets/update_post_main_widget.dart';
import '../../../../../app/di.dart' as di;


class UpdatePostScreen extends StatelessWidget {
  final PostEntity post;
  const UpdatePostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return BlocProvider<PostCubit>(
      create: (context) => di.instance<PostCubit>(),
      child: UpdatePostMainWidget(post: post),
    );

  }
}
