import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../user/presentation/profile/widgets/input_edit_profile_widget.dart';
import '../../domain/entities/replay_entity.dart';
import '../cubit/replay_cubit.dart';


class EditReplayMainWidget extends StatefulWidget {
  final ReplayEntity replay;
  const EditReplayMainWidget({Key? key, required this.replay})
      : super(key: key);

  @override
  State<EditReplayMainWidget> createState() => _EditReplayMainWidgetState();
}

class _EditReplayMainWidgetState extends State<EditReplayMainWidget> {
  TextEditingController? _descriptionController;

  bool _isReplayUpdating = false;

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.replay.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Replay"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            InputEditProfileWidget(
              label: "description",
              textController: _descriptionController,
              isProfile: false,
            ),
            AppConstants.sizeHor(AppSize.s10),
            MainButton(
              title: "Save Changes",
              onTap: () {
                _editReplay();
              },
            ),
            AppConstants.sizeHor(AppSize.s10),
            _isReplayUpdating == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Updating...",
                        style: TextStyle(color: Colors.white),
                      ),
                      AppConstants.sizeHor(AppSize.s10),
                      const CircularProgressIndicator(),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  _editReplay() {
    setState(() {
      _isReplayUpdating = true;
    });
    BlocProvider.of<ReplayCubit>(context).updateReplay(replay: ReplayEntity(
        postId: widget.replay.postId,
        commentId: widget.replay.commentId,
        replayId: widget.replay.replayId,
        description: _descriptionController!.text
    )).then((value) {
      setState(() {
        _isReplayUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
