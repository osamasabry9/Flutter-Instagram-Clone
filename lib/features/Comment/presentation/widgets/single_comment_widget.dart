import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../../../app/di.dart' as di;
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/usecases/get_current_uid_usecase.dart';
import '../../domain/entities/comment_entity.dart';

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  final UserEntity? currentUser;

  const SingleCommentWidget(
      {Key? key,
      required this.comment,
      this.onLongPressListener,
      this.onLikeClickListener,
      this.currentUser})
      : super(key: key);

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  final TextEditingController _replayDescriptionController =
      TextEditingController();
  String _currentUid = "";

  @override
  void initState() {
    di.instance<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });

    super.initState();
  }

  bool _isUserReplaying = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.comment.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    child: imageProfileWidget(
                        imageUrl: widget.comment.userProfileUrl),
                  ),
                ),
                AppConstants.sizeHor(AppSize.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "${widget.comment.username}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: ColorManager.white),
                            ),
                          ),
                          GestureDetector(
                              onTap: widget.onLikeClickListener,
                              child: Icon(
                                widget.comment.likes!.contains(_currentUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: AppSize.s20,
                                color:
                                    widget.comment.likes!.contains(_currentUid)
                                        ? Colors.red
                                        : ColorManager.grey,
                              ))
                        ],
                      ),
                      AppConstants.sizeVer(AppSize.s4),
                      Text(
                        "${widget.comment.description}",
                        style: const TextStyle(color: ColorManager.white),
                      ),
                      AppConstants.sizeVer(AppSize.s4),
                      Row(
                        children: [
                          Text(
                            DateFormat("dd/MMM/yyy")
                                .format(widget.comment.createAt!.toDate()),
                            style: const TextStyle(color: ColorManager.grey),
                          ),
                          AppConstants.sizeHor(AppSize.s12),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isUserReplaying = !_isUserReplaying;
                              });
                            },
                            child: const Text(
                              "Replay",
                              style: TextStyle(color: ColorManager.grey),
                            ),
                          ),
                          AppConstants.sizeHor(AppSize.s12),
                          const Text(
                            "View Replays",
                            style: TextStyle(color: ColorManager.grey),
                          ),
                        ],
                      ),
                      _isUserReplaying == true
                          ? AppConstants.sizeVer(10)
                          : AppConstants.sizeVer(0),
                      _isUserReplaying == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InputField(
                                  label: "",
                                  hint: "Post your replay...",
                                  textController: _replayDescriptionController,
                                  validate: (p0) {
                                    return null;
                                  },
                                ),
                                AppConstants.sizeVer(10),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    "Post",
                                    style:
                                        TextStyle(color: ColorManager.primary),
                                  ),
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
