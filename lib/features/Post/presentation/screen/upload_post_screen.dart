import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../cubit/post_cubit.dart';
import '../../../../../app/di.dart' as di;
import '../widgets/upload_post_main_widget.dart';


class UploadPostScreen extends StatelessWidget {
  final UserEntity currentUser;
  const UploadPostScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return BlocProvider<PostCubit>(
      create: (context) => di.instance<PostCubit>(),
      child: UploadPostMainWidget(currentUser: currentUser),
    );

  }
}
