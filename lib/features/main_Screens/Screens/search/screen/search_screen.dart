import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/Post/presentation/cubit/post_cubit.dart';

import '../widgets/search_main_widget.dart';
import '../../../../../app/di.dart' as di;


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<PostCubit>(
      create: (context) =>di.instance<PostCubit>(),
      child: const SearchMainWidget(),
    );
  }
}
