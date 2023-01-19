import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../../../app/di.dart' as di;
import '../../../user/domain/usecases/get_current_uid_usecase.dart';
import '../../domain/entities/replay_entity.dart';

class SingleReplayWidget extends StatefulWidget {
  final ReplayEntity replay;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  const SingleReplayWidget(
      {Key? key,
      required this.replay,
      this.onLongPressListener,
      this.onLikeClickListener})
      : super(key: key);

  @override
  State<SingleReplayWidget> createState() => _SingleReplayWidgetState();
}

class _SingleReplayWidgetState extends State<SingleReplayWidget> {
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.replay.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Container(
        margin: const EdgeInsets.only(left: AppMargin.m12, top: AppMargin.m12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.s40,
              height: AppSize.s40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s20),
                child:
                    imageProfileWidget(imageUrl: widget.replay.userProfileUrl),
              ),
            ),
            AppConstants.sizeHor(AppSize.s10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.replay.username}",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: ColorManager.white),
                        ),
                        GestureDetector(
                            onTap: widget.onLikeClickListener,
                            child: Icon(
                              widget.replay.likes!.contains(_currentUid)
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 20,
                              color: widget.replay.likes!.contains(_currentUid)
                                  ? ColorManager.error
                                  : ColorManager.white,
                            ))
                      ],
                    ),
                    AppConstants.sizeVer(4),
                    Text(
                      "${widget.replay.description}",
                      style: const TextStyle(color: ColorManager.white),
                    ),
                    AppConstants.sizeVer(4),
                    Text(
                      DateFormat("dd/MMM/yyy")
                          .format(widget.replay.createAt!.toDate()),
                      style: const TextStyle(color: ColorManager.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
