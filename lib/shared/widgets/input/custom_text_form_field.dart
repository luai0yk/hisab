import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';

import '../../../core/constants/theme/custom_theme/custom_input_border_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function()? onTap;
  final Function(String text)? onChanged;
  final bool readOnly;
  final bool canRequestFocus;
  final bool withMargin;
  final bool withBottomPadding;
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
    this.onChanged,
    this.readOnly = false,
    this.withMargin = false,
    this.withBottomPadding = true,
    this.canRequestFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Get.theme.extension<ColorExtension>()!;

    return Container(
      padding: withBottomPadding
          ? const EdgeInsets.only(bottom: Constants.spaceWith15x)
          : EdgeInsets.zero,
      margin: withMargin
          ? const EdgeInsets.symmetric(horizontal: Constants.spaceWith15x)
          : EdgeInsets.zero,
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly,
        canRequestFocus: canRequestFocus,
        style: CustomTextTheme.textStyle,
        textInputAction: TextInputAction.next,
        cursorColor: Constants.primaryColor.withOpacity(.5),
        cursorWidth: 3,
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
          border: CustomInputBorderTheme.borderTheme(
              borderColor: Colors.red, isBordered: true),
          enabledBorder: CustomInputBorderTheme.borderTheme(),
          focusedBorder: CustomInputBorderTheme.borderTheme(isBordered: true),
          errorBorder: CustomInputBorderTheme.borderTheme(
            isBordered: true,
            borderColor: Colors.red,
          ),
          hintText: hint.toUpperCase(),
          hintStyle: CustomHintStyle.hintStyle,
        ),
        validator: validator,
      ),
    );
  }
}
