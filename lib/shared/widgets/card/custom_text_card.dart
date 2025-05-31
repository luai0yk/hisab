import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';

class CustomTextCard extends StatelessWidget {
  final String text;
  const CustomTextCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return Container(
      padding: const EdgeInsets.all(Constants.spaceWith15x),
      margin: const EdgeInsets.only(bottom: Constants.spaceWith15x),
      decoration: BoxDecoration(
        color: customColors.backgroundGray,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Text(
        text,
        style: CustomHintStyle.hintStyle,
      ),
    );
  }
}
