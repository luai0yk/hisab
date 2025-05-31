import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'color_extension.dart';
import 'custom_theme/custom_elevated_button_theme.dart';

class DarkTheme {
  static final dark = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ColorExtension(
        primaryAccent: Constants.primaryColor,
        foregroundGray: CupertinoColors.systemGrey,
        backgroundGray: CupertinoColors.darkBackgroundGray,
      ),
    ],
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Constants.primaryColor,
      selectionHandleColor: Constants.primaryColor,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: CupertinoColors.black),
    scaffoldBackgroundColor: CupertinoColors.black,
    elevatedButtonTheme: CustomElevatedButtonTheme.buttonTheme,
  );
}
