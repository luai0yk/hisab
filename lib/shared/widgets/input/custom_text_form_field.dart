import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool obscureText;
  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.maxLength,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Get.theme.extension<ColorExtension>()!;

    return TextFormField(
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
      controller: controller,
      cursorRadius: const Radius.circular(Constants.radius),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: customColors.foregroundGray),
        filled: true,
        fillColor: customColors.backgroundGray,
        border: border(borderColor: Colors.red, isBordered: true),
        enabledBorder: border(),
        focusedBorder: border(
          borderColor: Constants.primaryColor,
          isBordered: true,
        ),
        errorBorder: border(borderColor: Colors.red, isBordered: true),
        hintText: hint.toUpperCase(),
        hintStyle: CustomHintStyle.hintStyle,
      ),
      validator: validator,
    );
  }
}

OutlineInputBorder border({Color? borderColor, bool isBordered = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(Constants.radius),
    borderSide: isBordered
        ? BorderSide(
            color: borderColor!,
            width: Constants.borderWidth,
          )
        : BorderSide.none,
  );
}
