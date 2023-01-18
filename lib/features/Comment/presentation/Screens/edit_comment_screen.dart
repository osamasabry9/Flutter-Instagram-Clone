import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/comment_entity.dart';
import '../cubit/comment_cubit.dart';
import '../widgets/edit_comment_main_widget.dart';
import '../../../../../app/di.dart' as di;

class EditCommentScreen extends StatelessWidget {
  final CommentEntity comment;

  const EditCommentScreen({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => di.instance<CommentCubit>(),
      child: EditCommentMainWidget(comment: comment),
    );
  }
}