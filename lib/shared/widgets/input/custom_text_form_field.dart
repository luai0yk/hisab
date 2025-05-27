import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  const CustomTextFormField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Constants.x6Space),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: CupertinoColors.lightBackgroundGray,
          enabledBorder: border(borderColor: Colors.black26),
          focusedBorder: border(
            borderColor: Colors.blueAccent,
            isBordered: true,
          ),
          errorBorder: border(borderColor: Colors.red),
          hintText: hint,
        ),
      ),
    );
  }
}

OutlineInputBorder border(
    {required Color borderColor, bool isBordered = false}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(Constants.radius),
    borderSide: isBordered
        ? BorderSide(
            color: borderColor,
            width: Constants.borderWidth,
          )
        : BorderSide.none,
  );
}
