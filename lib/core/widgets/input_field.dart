import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/values_manager.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLine;
  final TextInputType inputType;
  final IconData? prefix;
  final bool isPassword;
  final IconData? suffix;
  final dynamic suffixPressed;
  final String? Function(String?) validate;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onSave;
  final String? Function(String?)? onChanged;

  final TextEditingController textController;
  final TextStyle? style;

  // ignore: use_key_in_widget_constructors
  const InputField({
    required this.textController,
    required this.label,
    this.hint = "",
    this.maxLine = 1,
    this.inputType = TextInputType.text,
    this.prefix,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    required this.validate,
    this.onFieldSubmitted,
    this.style,
    this.onSave,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSize.s18),
        child: TextFormField(
          onChanged: onChanged,
          onSaved: onSave,
          controller: textController,
          keyboardType: inputType,
          obscureText: isPassword,
          validator: validate,
          maxLines: maxLine,
          style: style,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: style,
            prefixIcon: Icon(
              prefix,
              size: AppSize.s20,
              color: ColorManager.grey,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                      size: AppSize.s20,
                      color: ColorManager.grey,
                    ))
                : null,
          ),
        ),
      ),
    );
  }
}
