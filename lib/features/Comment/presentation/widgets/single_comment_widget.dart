import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../auth/presentation/widgets/profile_widget.dart';

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({super.key});

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  final TextEditingController _replayDescriptionController =
      TextEditingController();
  bool _isUserReplaying = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: profileWidget(imageUrl: ""),
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
                            "Username",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: ColorManager.white),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.favorite_outline,
                              size: AppSize.s25,
                            )),
                      ],
                    ),
                    AppConstants.sizeVer(AppSize.s4),
                    const Text(
                      "This is Comment ",
                      style: TextStyle(color: ColorManager.white),
                    ),
                    AppConstants.sizeVer(AppSize.s4),
                    Row(
                      children: [
                        const Text(
                          "22/22/2022",
                          style: TextStyle(color: ColorManager.grey),
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
                                  style: TextStyle(color: ColorManager.primary),
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
    );
  }
}
