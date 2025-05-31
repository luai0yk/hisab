import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';

class CustomTextCard extends StatelessWidget {
  final String text;
  final String hint;
  final Color? color;
  final Color? textColor;
  const CustomTextCard({
    super.key,
    required this.text,
    required this.hint,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return Container(
      padding: const EdgeInsets.all(Constants.spaceWith15x),
      margin: const EdgeInsets.only(bottom: Constants.spaceWith10x),
      decoration: BoxDecoration(
        color: color ?? customColors.backgroundGray,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: CustomHintStyle.hintStyle.copyWith(fontSize: 12),
          ),
          const SizedBox(height: Constants.spaceWith4x),
          Text(
            text,
            style: CustomTextTheme.textStyle.copyWith(
              fontSize: 18,
              color: textColor ?? customColors.foregroundGray,
            ),
          ),
        ],
      ),
    );
  }
}
