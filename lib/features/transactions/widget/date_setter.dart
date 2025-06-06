import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../../core/localization/locale_key.dart';
import '../../../shared/widgets/button/custom_icon_button.dart';

class DateSetter {
  static void setDate({context, controller}) {
    ColorExtension customColors = Get.theme.extension()!;
    BottomPicker.date(
      pickerTitle: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.spaceWith10x,
        ),
        child: Text(
          LocaleKey.transactionDate.tr,
          style: CustomTextTheme.textStyle.copyWith(
            fontSize: 22,
          ),
        ),
      ),
      initialDateTime: DateTime.now(),
      pickerTextStyle: CustomTextTheme.textStyle.copyWith(
        fontSize: 18,
      ),
      backgroundColor: customColors.surfaceColor,
      onChange: (index) {
        controller.setDateTime(dateTime: index);
      },
      displaySubmitButton: false,
      buttonStyle: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(
          Constants.radius,
        ),
      ),
      buttonWidth: 300,
      closeWidget: CustomIconButton(
        icon: HugeIcons.strokeRoundedMultiplicationSign,
        toolTip: LocaleKey.close.tr,
        onPressed: () => Get.back(),
      ),
    ).show(context);
  }
}
