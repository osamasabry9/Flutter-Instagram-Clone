import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import 'package:instagram_clone/core/utils/values_manager.dart';


import '../../../../core/utils/color_manager.dart';
import '../../../auth/presentation/widgets/profile_widget.dart';

class SingleReplayWidget extends StatefulWidget {
  const SingleReplayWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleReplayWidget> createState() => _SingleReplayWidgetState();
}

class _SingleReplayWidgetState extends State<SingleReplayWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
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
                child: profileWidget(imageUrl: ''),
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
                          "Username",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: ColorManager.white),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    AppConstants.sizeVer(4),
                    const Text(
                      "description",
                      style: TextStyle(color: ColorManager.white),
                    ),
                    AppConstants.sizeVer(4),
                    const Text(
                      "22/22/2022",
                      style: TextStyle(color: ColorManager.grey),
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
