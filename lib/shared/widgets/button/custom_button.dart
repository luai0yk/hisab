import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Constants.size20,
          color: Colors.white,
        ),
      ),
    );
  }
}
