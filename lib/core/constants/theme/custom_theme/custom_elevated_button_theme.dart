import 'package:flutter/material.dart';

import '../../constants.dart';

abstract class CustomElevatedButtonTheme {
  static ElevatedButtonThemeData get buttonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Constants.radius,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
