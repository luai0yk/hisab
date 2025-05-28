import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'color_extension.dart';
import 'custom_theme/custom_elevated_button_theme.dart';

class LightTheme {
  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const ColorExtension(
        primaryAccent: Colors.blueAccent,
        foregroundGray: CupertinoColors.secondaryLabel,
        backgroundGray: CupertinoColors.lightBackgroundGray,
      ),
    ],
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
    ).copyWith(
      onSurface: CupertinoColors.lightBackgroundGray,
      surface: CupertinoColors.white,
      primary: Constants.primaryColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Constants.primaryColor,
      selectionHandleColor: Constants.primaryColor,
    ),
    scaffoldBackgroundColor: CupertinoColors.white,
    elevatedButtonTheme: CustomElevatedButtonTheme.buttonTheme,
  );
}
