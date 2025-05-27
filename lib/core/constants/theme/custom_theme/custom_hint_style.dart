import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomHintStyle {
  static TextStyle get hintStyle {
    return TextStyle(
      color: Get.isDarkMode
          ? CupertinoColors.systemGrey
          : CupertinoColors.secondaryLabel,
    );
  }
}
