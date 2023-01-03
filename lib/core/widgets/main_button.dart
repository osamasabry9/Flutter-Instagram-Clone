import 'package:flutter/material.dart';
import '../utils/color_manager.dart';
import '../utils/font_manager.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Color color;
  // final Color colorBorder;
  final double? height;
  final double width;
  final double borderRadius;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  // ignore: use_key_in_widget_constructors
  const MainButton({
    this.title = "",
    this.color = ColorManager.primary,
    //this.colorBorder = ColorManager.primary,
    this.height,
    this.width = double.infinity,
    this.borderRadius = 20,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? size.height * 0.07,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: color, width: 1)),
        child: Text(
          title.toUpperCase(),
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: ColorManager.white, fontSize: FontSize.s18),
        ),
      ),
    );
  }
}
