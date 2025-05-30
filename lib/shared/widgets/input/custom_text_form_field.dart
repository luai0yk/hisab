import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';

import '../../../core/constants/theme/custom_theme/custom_input_border.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function()? onTap;
  final bool readOnly;
  final bool canRequestFocus;
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.maxLength,
    this.validator,
    this.obscureText = false,
    this.textInputType,
    this.onTap,
    this.readOnly = false,
    this.canRequestFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Get.theme.extension<ColorExtension>()!;

    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      canRequestFocus: canRequestFocus,
      style: CustomTextTheme.textStyle,
      textInputAction: TextInputAction.next,
      cursorColor: Constants.primaryColor.withOpacity(.5),
      cursorWidth: 5,
      maxLength: maxLength,
      obscureText: obscureText,
      buildCounter: (context,
          {required currentLength, required isFocused, required maxLength}) {
        return const SizedBox();
      },
      keyboardType: textInputType ?? TextInputType.text,
      controller: controller,
      cursorRadius: const Radius.circular(Constants.radius),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: customColors.foregroundGray),
        filled: true,
        fillColor: customColors.backgroundGray,
        border: CustomInputBorder.borderTheme(
            borderColor: Colors.red, isBordered: true),
        enabledBorder: CustomInputBorder.borderTheme(),
        focusedBorder: CustomInputBorder.borderTheme(isBordered: true),
        errorBorder: CustomInputBorder.borderTheme(
          isBordered: true,
          borderColor: Colors.red,
        ),
        hintText: hint.toUpperCase(),
        hintStyle: CustomHintStyle.hintStyle,
      ),
      validator: validator,
    );
  }
}
