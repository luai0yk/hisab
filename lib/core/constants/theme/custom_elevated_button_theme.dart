import 'package:flutter/material.dart';

import '../constants.dart';

abstract class CustomElevatedButtonTheme {
  static ElevatedButtonThemeData get theme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
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
