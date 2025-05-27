import 'package:flutter/material.dart';
import 'package:hisab/core/constants/theme/custom_elevated_button_theme.dart';

import 'color_extension.dart';

class LightTheme {
  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const ColorExtension(
        primaryAccent: Colors.blueAccent,
      ),
    ],
    elevatedButtonTheme: CustomElevatedButtonTheme.theme,
  );
}
