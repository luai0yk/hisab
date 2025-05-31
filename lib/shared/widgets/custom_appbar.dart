import 'package:flutter/material.dart';

import '../../core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomAppbar {
  static AppBar appBar({List<Widget>? actions, required String title}) {
    return AppBar(
      actions: actions,
      title: Text(
        title.toUpperCase(),
        style: CustomTextTheme.textStyle.copyWith(fontSize: 20),
      ),
    );
  }
}
