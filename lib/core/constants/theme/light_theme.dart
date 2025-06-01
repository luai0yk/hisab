import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'color_extension.dart';

class LightTheme {
  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ColorExtension(
        primaryAccent: Constants.primaryColor,
        foregroundGray: CupertinoColors.secondaryLabel,
        backgroundGray: CupertinoColors.lightBackgroundGray,
        surfaceColor: CupertinoColors.white,
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
    appBarTheme: const AppBarTheme(
      backgroundColor: CupertinoColors.white,
      surfaceTintColor: CupertinoColors.white,
    ),
    scaffoldBackgroundColor: CupertinoColors.white,
    // elevatedButtonTheme: CustomElevatedButtonTheme.buttonTheme,
  );
}
