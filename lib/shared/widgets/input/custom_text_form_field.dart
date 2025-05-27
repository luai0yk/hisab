import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  const CustomTextFormField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Constants.x6Space),
      child: TextFormField(
        style: CustomTextTheme.textStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: Get.isDarkMode
              ? CupertinoColors.darkBackgroundGray
              : CupertinoColors.lightBackgroundGray,
          enabledBorder: border(borderColor: Colors.black26),
          focusedBorder: border(
            borderColor: Colors.blueAccent,
            isBordered: true,
          ),
          errorBorder: border(borderColor: Colors.red),
          hintText: hint,
          hintStyle: CustomHintStyle.hintStyle,
        ),
      ),
    );
  }
}

OutlineInputBorder border(
    {required Color borderColor, bool isBordered = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(Constants.radius),
    borderSide: isBordered
        ? BorderSide(
            color: borderColor,
            width: Constants.borderWidth,
          )
        : BorderSide.none,
  );
}
