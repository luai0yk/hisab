import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';

class CustomerItem extends StatelessWidget {
  final CustomerModel customer;
  const CustomerItem({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.spaceWith15x),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
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
                  customer.name!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (!customer.isSynced!) ...[
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemRed.withOpacity(.7),
                    shape: BoxShape.circle,
                  ),
                )
              ]
            ],
          ),
          const SizedBox(width: Constants.spaceWith15x),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name!,
                style: CustomTextTheme.textStyle.copyWith(fontSize: 22),
              ),
              Text(
                customer.addedAt!,
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
