import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Constants.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: Constants.spaceWith10x),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Constants.radius,
          ),
        ),
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Constants.size20,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
