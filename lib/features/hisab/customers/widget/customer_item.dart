import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                customer.name!.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
            Center(
              child: Container(
                padding: const EdgeInsets.all(Constants.spaceWith4x),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemRed.withOpacity(.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: Constants.spaceWith20x),
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
      ),
    );
  }
}
