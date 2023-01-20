import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../../../app/di.dart' as di;
import '../../../replay/domain/entities/replay_entity.dart';
import '../../../replay/presentation/cubit/replay_cubit.dart';
import '../../../replay/presentation/widgets/single_replay_widget.dart';
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
    BlocProvider.of<ReplayCubit>(context).getReplays(
        replay: ReplayEntity(
            postId: widget.comment.postId,
            commentId: widget.comment.commentId));
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
                          GestureDetector(
                            onTap: () {
                              widget.comment.totalReplays == 0
                                  ? AppConstants.toast("no replays")
                                  : BlocProvider.of<ReplayCubit>(context)
                                      .getReplays(
                                          replay: ReplayEntity(
                                              postId: widget.comment.postId,
                                              commentId:
                                                  widget.comment.commentId));
                            },
                            child: const Text(
                              "View Replays",
                              style: TextStyle(color: ColorManager.grey),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<ReplayCubit, ReplayState>(
                        builder: (context, replayState) {
                          if (replayState is ReplayLoaded) {
                            final replays = replayState.replays
                                .where((element) =>
                                    element.commentId ==
                                    widget.comment.commentId)
                                .toList();
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: replays.length,
                                itemBuilder: (context, index) {
                                  return SingleReplayWidget(
                                    replay: replays[index],
                                    onLongPressListener: () {
                                      _openBottomModalSheet(
                                          context: context,
                                          replay: replays[index]);
                                    },
                                    onLikeClickListener: () {
                                      _likeReplay(replay: replays[index]);
                                    },
                                  );
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
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
                                  onTap: () {
                                    _createReplay();
                                  },
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

  _createReplay() {
    BlocProvider.of<ReplayCubit>(context)
        .createReplay(
            replay: ReplayEntity(
      replayId: const Uuid().v1(),
      createAt: Timestamp.now(),
      likes: const [],
      username: widget.currentUser!.username,
      userProfileUrl: widget.currentUser!.profileUrl,
      creatorUid: widget.currentUser!.uid,
      postId: widget.comment.postId,
      commentId: widget.comment.commentId,
      description: _replayDescriptionController.text,
    ))
        .then((value) {
      setState(() {
        _replayDescriptionController.clear();
        _isUserReplaying = false;
      });
    });
  }

  _openBottomModalSheet(
      {required BuildContext context, required ReplayEntity replay}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration:
                BoxDecoration(color: ColorManager.darkGrey.withOpacity(.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorManager.white),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: ColorManager.black,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _deleteReplay(replay: replay);
                        },
                        child: const Text(
                          "Delete Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorManager.white),
                        ),
                      ),
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                    const Divider(
                      thickness: 1,
                      color: ColorManager.black,
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.updateReplayRoute,
                                  arguments: replay)
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text(
                          "Update Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorManager.white),
                        ),
                      ),
                    ),
                    AppConstants.sizeVer(AppSize.s8),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteReplay({required ReplayEntity replay}) {
    BlocProvider.of<ReplayCubit>(context)
        .deleteReplay(
            replay: ReplayEntity(
                postId: replay.postId,
                commentId: replay.commentId,
                replayId: replay.replayId))
        .then((value) => Navigator.pop(context));
  }

  _likeReplay({required ReplayEntity replay}) {
    BlocProvider.of<ReplayCubit>(context).likeReplay(
        replay: ReplayEntity(
            postId: replay.postId,
            commentId: replay.commentId,
            replayId: replay.replayId));
  }
}
