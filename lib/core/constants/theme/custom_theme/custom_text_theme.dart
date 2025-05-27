import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CustomTextTheme {
  static TextStyle get textStyle {
    return TextStyle(
      fontSize: Constants.size14,
      fontWeight: FontWeight.w500,
      color:
          Get.isDarkMode ? CupertinoColors.systemGrey6 : CupertinoColors.black,
    );
  }
}
