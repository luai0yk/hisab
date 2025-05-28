import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.spaceWith15x),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              'A',
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: Constants.spaceWith10x),
          Column(
            children: [
              Text(
                'Title',
                style: CustomTextTheme.textStyle.copyWith(fontSize: 22),
              ),
              Text(
                'subtitle',
                style: CustomHintStyle.hintStyle,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '744,4',
                style: CustomTextTheme.textStyle.copyWith(
                  color: CupertinoColors.systemGreen,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                LocaleKey.got.tr,
                style: CustomHintStyle.hintStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
