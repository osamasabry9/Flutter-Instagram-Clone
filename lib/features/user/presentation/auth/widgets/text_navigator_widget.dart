import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';

class TextNavigatorWidget extends StatelessWidget {
  const TextNavigatorWidget({
    super.key,
    required this.titleOne,
    required this.titleTwo,
    required this.onTap,
    required this.mainAxisAlignment,
  });

  final VoidCallback onTap;
  final String titleOne;
  final String titleTwo;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(titleOne, style: Theme.of(context).textTheme.titleMedium),
        GestureDetector(
            onTap: onTap,
            child: Text(
              titleTwo,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ColorManager.primary),
            )),
      ],
    );
  }
}
