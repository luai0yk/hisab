import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_extension.dart';
import 'custom_theme/custom_elevated_button_theme.dart';

class DarkTheme {
  static final dark = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const ColorExtension(
        primaryAccent: Colors.blueAccent,
        foregroundGray: CupertinoColors.systemGrey,
        backgroundGray: CupertinoColors.darkBackgroundGray,
      ),
    ],
    elevatedButtonTheme: CustomElevatedButtonTheme.buttonTheme,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
    ).copyWith(
      onSurface: CupertinoColors.darkBackgroundGray,
      surface: CupertinoColors.black,
      primary: Colors.blueAccent,
    ),
    scaffoldBackgroundColor: CupertinoColors.black,
  );
}
