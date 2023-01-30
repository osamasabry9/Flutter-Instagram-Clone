import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../user/presentation/profile/widgets/input_edit_profile_widget.dart';
import '../../domain/entities/comment_entity.dart';
import '../cubit/comment_cubit.dart';

class EditCommentMainWidget extends StatefulWidget {
  final CommentEntity comment;
  const EditCommentMainWidget({Key? key, required this.comment})
      : super(key: key);

  @override
  State<EditCommentMainWidget> createState() => _EditCommentMainWidgetState();
}

class _EditCommentMainWidgetState extends State<EditCommentMainWidget> {
  TextEditingController? _descriptionController;

  bool _isCommentUpdating = false;

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.comment.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Comment"),
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
                _editComment();
              },
            ),
            AppConstants.sizeHor(AppSize.s10),
            _isCommentUpdating == true
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

  _editComment() {
    setState(() {
      _isCommentUpdating = true;
    });
    BlocProvider.of<CommentCubit>(context)
        .updateComment(
            comment: CommentEntity(
                postId: widget.comment.postId,
                commentId: widget.comment.commentId,
                description: _descriptionController!.text))
        .then((value) {
      setState(() {
        _isCommentUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
