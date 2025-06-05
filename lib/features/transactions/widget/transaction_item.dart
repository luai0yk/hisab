import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/features/transactions/controller/view_transaction_controller.dart';
import 'package:hisab/features/transactions/model/transaction_model.dart';
import 'package:hisab/shared/widgets/icon/custom_huge_icon.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jiffy/jiffy.dart';

class TransactionItem extends GetView<ViewTransactionController> {
  final TransactionModel transaction;
  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isGot = transaction.type == 'got';
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(Constants.radius),
      child: Column(
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
                          style: CustomHintStyle.hintStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                      if (!transaction.isSynced!) ...[
                        Container(
                          margin: const EdgeInsets.only(
                            top: Constants.spaceWith4x,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Constants.spaceWith4x,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemRed.withOpacity(.1),
                            borderRadius:
                                BorderRadius.circular(Constants.radius),
                          ),
                          child: const Text(
                            'NOT SYNCED',
                            style: TextStyle(
                              color: CupertinoColors.systemRed,
                              fontWeight: FontWeight.w500,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: isGot
                          ? CupertinoColors.systemGreen
                          : CupertinoColors.systemRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                          text: '${transaction.amount!.toInt().toString()} '),
                      TextSpan(
                        text:
                            controller.customer.currency!.split('-')[0].trim(),
                        style: const TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
