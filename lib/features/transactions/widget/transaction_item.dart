import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedArrowUp02,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: Constants.spaceWith10x),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detain of Transaction',
                    style: CustomTextTheme.textStyle,
                  ),
                  Text(
                    '3 hours ago',
                    style: CustomHintStyle.hintStyle,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '400\$',
                style: CustomTextTheme.textStyle,
              ),
            ],
          ),
        ),
        Container(
          height: 1.5,
          width: (MediaQuery.of(context).size.width / 2),
          color: CupertinoColors.systemGrey.withOpacity(.1),
        ),
      ],
    );
  }
}
