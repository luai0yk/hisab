import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomHintStyle {
  static TextStyle get hintStyle {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode
          ? CupertinoColors.systemGrey
          : CupertinoColors.secondaryLabel,
    );
  }
}
