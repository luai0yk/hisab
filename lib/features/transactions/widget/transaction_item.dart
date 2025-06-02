import 'package:flutter/cupertino.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jiffy/jiffy.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isGot = transaction.type == 'got';
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
                  color: isGot
                      ? CupertinoColors.systemGreen.withOpacity(.1)
                      : CupertinoColors.systemRed.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: CustomHugeIcon(
                  icon: isGot
                      ? HugeIcons.strokeRoundedArrowUp02
                      : HugeIcons.strokeRoundedArrowDown02,
                  color: isGot
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemRed,
                ),
              ),
              const SizedBox(width: Constants.spaceWith10x),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Jiffy.parse(transaction.date!)
                          .format(pattern: 'dd/MMM/yy'),
                      style: CustomTextTheme.textStyle,
                    ),
                    if (transaction.description!.isNotEmpty) ...[
                      Text(
                        transaction.description!,
                        style: CustomHintStyle.hintStyle,
                      ),
                    ]
                  ],
                ),
              ),
              Text(
                transaction.amount.toString(),
                style: CustomTextTheme.textStyle.copyWith(
                  color: isGot
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemRed,
                ),
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
