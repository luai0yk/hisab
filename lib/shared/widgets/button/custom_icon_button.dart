import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData? icon;
  final String? toolTip;
  const CustomIconButton({
    super.key,
    this.toolTip,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return IconButton(
      onPressed: onPressed,
      tooltip: toolTip ?? '',
      icon: HugeIcon(
        icon: icon!,
        color: customColors.foregroundGray,
      ),
    );
  }
}
