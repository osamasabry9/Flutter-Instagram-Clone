import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/replay_entity.dart';
import '../cubit/replay_cubit.dart';
import '../../../../../app/di.dart' as di;
import '../widgets/edit_replay_main_widget.dart';

class EditReplayScreen extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayScreen({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.instance<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}