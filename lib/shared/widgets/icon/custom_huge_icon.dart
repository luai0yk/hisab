import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/theme/color_extension.dart';

class CustomHugeIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  const CustomHugeIcon({
    super.key,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return HugeIcon(
      icon: icon,
      color: color ?? customColors.foregroundGray,
    );
  }
}
