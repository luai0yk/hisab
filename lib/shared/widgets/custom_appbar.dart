import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';

import '../../core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomAppbar extends StatelessWidget {
  final List<Widget>? actions;
  final String? title;
  const CustomAppbar({
    super.key,
    this.actions,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.spaceWith10x),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? '',
            style: CustomTextTheme.textStyle.copyWith(
              fontSize: 22,
            ),
          ),
          const Spacer(),
          Row(children: actions ?? []),
        ],
      ),
    );
  }
}
