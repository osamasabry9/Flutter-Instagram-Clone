import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';

class SelectSectionWidget extends StatelessWidget {
  const SelectSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.grid_on_sharp,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_library_outlined,
                color: ColorManager.grey1),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_pin_outlined,
                color: ColorManager.grey1),
          ),
        ],
      ),
    );
  }
}
