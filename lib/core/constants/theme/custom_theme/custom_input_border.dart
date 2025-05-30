import 'package:flutter/material.dart';

import '../../constants.dart';

abstract class CustomInputBorder {
  static OutlineInputBorder borderTheme(
      {Color? borderColor, bool isBordered = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.radius),
      borderSide: isBordered
          ? BorderSide(
              color: borderColor ?? Constants.primaryColor,
              width: Constants.borderWidth,
            )
          : BorderSide.none,
    );
  }
}
