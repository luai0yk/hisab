import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';

class AppDialog extends StatelessWidget {
  final String? title, content;
  final Function()? onOkay, onCancel, onOther;
  final String? okayText, cancelText, otherText;
  final Widget? customContent;
  final Color? okayColor;

  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.onOkay,
    this.onCancel,
    this.onOther,
    this.okayText,
    this.cancelText,
    this.otherText,
    this.customContent,
    this.okayColor,
  });

  @override
  Widget build(BuildContext context) {
    ColorExtension customColors = Get.theme.extension<ColorExtension>()!;
    return AlertDialog(
      backgroundColor: customColors.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      titlePadding: const EdgeInsets.all(Constants.spaceWith15x),
      contentPadding: customContent != null
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: Constants.spaceWith15x),
      actionsPadding: const EdgeInsets.all(Constants.spaceWith8x),
      title: title != null
          ? Text(
              title!,
              style: CustomTextTheme.textStyle.copyWith(fontSize: 20),
            )
          : null,
      content: customContent ??
          (content != null
              ? Text(
                  content!,
                  style: CustomTextTheme.textStyle.copyWith(fontSize: 20),
                )
              : null),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (onCancel != null)
              CustomButton(
                text: cancelText ?? LocaleKey.no.tr,
                onPressed: () {
                  onCancel!();
                  Navigator.of(context).pop();
                },
              ),
            const SizedBox(width: Constants.spaceWith10x),
            if (onOkay != null)
              CustomButton(
                text: okayText ?? LocaleKey.yes.tr,
                onPressed: () {
                  onOkay!();
                  Navigator.of(context).pop();
                },
                color: okayColor,
              ),
            if (onOther != null)
              CustomButton(
                text: otherText ?? 'Other',
                onPressed: () {
                  onOther!();
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ],
    );
  }
}
