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
  const CustomerItem({
    super.key,
    required this.customer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Constants.radius),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Constants.spaceWith10x),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
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
                ),
                const SizedBox(width: Constants.spaceWith15x),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name!,
                        style: CustomTextTheme.textStyle.copyWith(fontSize: 20),
                      ),
                      Text(
                        Jiffy.parse(customer.addedAt!).fromNow(),
                        style: CustomHintStyle.hintStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(Constants.spaceWith4x),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemRed.withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: Constants.spaceWith20x),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${customer.netBalance.toInt()}.${customer.currency!.split('-')[0].trim()}',
                        style: CustomTextTheme.textStyle.copyWith(
                          color: customer.netBalance == 0
                              ? Constants.primaryColor
                              : customer.isCustomerGiven
                                  ? CupertinoColors.systemRed
                                  : CupertinoColors.systemGreen,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        customer.netBalance == 0
                            ? 'Empty'
                            : customer.isCustomerGiven
                                ? LocaleKey.gave.tr
                                : LocaleKey.got.tr,
                        style: CustomHintStyle.hintStyle,
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
