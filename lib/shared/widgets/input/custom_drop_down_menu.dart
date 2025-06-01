import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_input_border_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/theme/color_extension.dart';
import '../../../../core/constants/theme/custom_theme/custom_hint_style.dart';
import '../../../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../../../shared/widgets/icon/custom_huge_icon.dart';

class CustomDropDownMenu extends StatelessWidget {
  final SingleSelectController<String> controller;
  final List<String> items;
  const CustomDropDownMenu(
      {super.key, required this.controller, required this.items});

  @override
  Widget build(BuildContext context) {
    final ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return CustomDropdown<String>.search(
      controller: controller,
      hintText: LocaleKey.chooseCurrency.tr.toUpperCase(),
      noResultFoundBuilder: (context, text) => Center(
        child: Padding(
          padding: const EdgeInsets.all(Constants.spaceWith15x),
          child: Text(
            LocaleKey.noCurrencyFound.tr,
            style: CustomTextTheme.textStyle,
          ),
        ),
      ),
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
        closedBorderRadius: BorderRadius.circular(Constants.radius),
        listItemStyle: CustomTextTheme.textStyle,
        expandedFillColor: customColors.backgroundGray,
        hintStyle: CustomHintStyle.hintStyle,
        closedFillColor: customColors.backgroundGray,
        headerStyle: CustomTextTheme.textStyle,
        searchFieldDecoration: SearchFieldDecoration(
          hintStyle: CustomHintStyle.hintStyle,
          fillColor: customColors.backgroundGray,
          textStyle: CustomTextTheme.textStyle,
          prefixIcon: const CustomHugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
          ),
          suffixIcon: (onClear) {
            return IconButton(
              icon: const CustomHugeIcon(
                icon: HugeIcons.strokeRoundedMultiplicationSign,
              ),
              tooltip: LocaleKey.clear.tr,
              onPressed: onClear,
            );
          },
          border: CustomInputBorderTheme.borderTheme(
            isBordered: true,
            borderColor: customColors.foregroundGray,
          ),
          focusedBorder: CustomInputBorderTheme.borderTheme(isBordered: true),
        ),
      ),
      searchHintText: LocaleKey.search.tr.toUpperCase(),
      closedHeaderPadding: const EdgeInsets.all(Constants.spaceWith15x),
      items: items,
      onChanged: (value) {},
    );
  }
}
