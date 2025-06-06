import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:jiffy/jiffy.dart';

import '../../../shared/model/customer_model.dart';

class CustomerItem extends StatelessWidget {
  final CustomerModel customer;
  final Function() onTap;
  final Function()? onLongPress;
  const CustomerItem({
    super.key,
    required this.customer,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(Constants.radius),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Constants.spaceWith10x),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    customer.name!.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: Constants.spaceWith15x),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name!,
                        style: CustomTextTheme.textStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        Jiffy.parse(customer.addedAt!).fromNow(),
                        style: CustomHintStyle.hintStyle.copyWith(fontSize: 10),
                      ),
                      if (!customer.isSynced!) ...[
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
                      ]
                    ],
                  ),
                ),
                const SizedBox(width: Constants.spaceWith20x),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: customer.isCustomerEmpty
                                ? Constants.primaryColor
                                : customer.isCustomerGiven
                                    ? CupertinoColors.systemRed
                                    : CupertinoColors.systemGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(text: '${customer.netBalance} '),
                            TextSpan(
                                text: customer.currency!.split('-')[0].trim(),
                                style: const TextStyle(fontSize: 8)),
                          ],
                        ),
                      ),
                      Text(
                        customer.isCustomerSettled
                            ? 'Settled'
                            : customer.netBalance == 0
                                ? LocaleKey.empty.tr
                                : customer.isCustomerGiven
                                    ? LocaleKey.gave.tr
                                    : LocaleKey.got.tr,
                        style: CustomHintStyle.hintStyle.copyWith(fontSize: 12),
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
