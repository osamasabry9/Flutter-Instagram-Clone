import 'package:flutter/material.dart';
import '../../../../core/utils/values_manager.dart';
import 'single_comment_widget.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../auth/presentation/widgets/profile_widget.dart';

class CommentMainWidget extends StatefulWidget {
  const CommentMainWidget({super.key});

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoPostSection(),
        const Divider(
          color: ColorManager.grey,
        ),
        AppConstants.sizeVer(AppSize.s12),
        const Expanded(
          child: SingleCommentWidget(),
        ),
        _commentSection(),
      ],
    );
  }

  _infoPostSection() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    child: profileWidget(imageUrl: ""),
                  ),
                ),
                AppConstants.sizeHor(AppSize.s12),
                Text(
                  "Username",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.white),
                )
              ],
            ),
          ),
          AppConstants.sizeVer(AppSize.s12),
          const Text(
            "post description",
            style: TextStyle(color: ColorManager.white),
          ),
          AppConstants.sizeVer(AppSize.s12),
        ],
      ),
    );
  }

  _commentSection() {
    return Container(
      width: double.infinity,
      height: AppSize.s60,
      color: ColorManager.darkGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Row(
          children: [
            SizedBox(
              width: AppSize.s40,
              height: AppSize.s40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: profileWidget(imageUrl: ""),
              ),
            ),
            AppConstants.sizeHor(AppSize.s10),
            Expanded(
              child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Post your comment...",
              ),
            )),
            GestureDetector(
                onTap: () {},
                child: Text(
                  "Post",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorManager.primary),
                ))
          ],
        ),
      ),
    );
  }
}
