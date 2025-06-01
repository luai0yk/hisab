import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../../shared/widgets/icon/custom_huge_icon.dart';

class CustomDropDown extends StatelessWidget {
  final SingleSelectController controller;
  final List<String> items;
  const CustomDropDown({
    super.key,
    required this.controller,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    ColorExtension customColors = Get.theme.extension<ColorExtension>()!;
    return CustomDropdown(
      items: items,
      controller: controller,
      onChanged: (p0) {},
      decoration: CustomDropdownDecoration(
        prefixIcon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedMoney03,
        ),
        closedSuffixIcon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedArrowDown01,
        ),
        expandedSuffixIcon: const CustomHugeIcon(
          icon: HugeIcons.strokeRoundedArrowUp01,
        ),
        headerStyle: CustomTextTheme.textStyle,
        closedBorderRadius: BorderRadius.circular(Constants.radius),
        listItemStyle: CustomTextTheme.textStyle,
        expandedFillColor: customColors.backgroundGray,
        closedFillColor: customColors.backgroundGray,
      ),
    );
  }
}
