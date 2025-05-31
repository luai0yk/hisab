import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'color_extension.dart';
import 'custom_theme/custom_elevated_button_theme.dart';

class LightTheme {
  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ColorExtension(
        primaryAccent: Constants.primaryColor,
        foregroundGray: CupertinoColors.secondaryLabel,
        backgroundGray: CupertinoColors.lightBackgroundGray,
      ),
    ],
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Constants.primaryColor,
      selectionHandleColor: Constants.primaryColor,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: CupertinoColors.white),
    scaffoldBackgroundColor: CupertinoColors.white,
    elevatedButtonTheme: CustomElevatedButtonTheme.buttonTheme,
  );
}
