import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';

class InputEditProfileWidget extends StatelessWidget {
  final String label;
  final bool isProfile;

  final TextEditingController textController;

  const InputEditProfileWidget({
    Key? key,
    required this.label,
    required this.textController,
    this.isProfile = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p8,
          ),
          child: Row(
            children: [
              if (isProfile)
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: AppSize.s16,
                        color: ColorManager.grey,
                      ),
                ),
              if (isProfile)
                const SizedBox(
                  width: AppSize.s14,
                ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  textAlign: isProfile ? TextAlign.end : TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: AppSize.s16,
                        color: ColorManager.white,
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '$label must be filled';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: ColorManager.background,
                    label: Text(
                      isProfile ? "" : label,
                    ),
                    labelStyle:
                        Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: AppSize.s16,
                              color: ColorManager.white,
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: ColorManager.grey1,
          height: 1,
        ),
      ],
    );
  }
}
