import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:hisab/shared/widgets/appbar/custom_appbar.dart';
import 'package:hisab/shared/widgets/card/custom_text_card.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/localization/locale_key.dart';

class CustomerProfilePage extends StatelessWidget {
  final CustomerModel customer = Get.arguments;

  CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: "${customer.name!.split(' ')[0]} ${LocaleKey.profile.tr}",
      ),
      body: ListView(
        padding: const EdgeInsets.all(Constants.spaceWith15x),
        children: [
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              customer.name!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.w900,
                color: Constants.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: Constants.spaceWith15x),
          Center(
            child: Text(
              customer.name!.toUpperCase(),
              style: CustomTextTheme.textStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Text(
              Jiffy.parse(customer.addedAt!).format(pattern: 'dd/MMM/yyyy'),
              style: CustomHintStyle.hintStyle,
            ),
          ),
          const SizedBox(height: Constants.spaceWith20x),
          Row(
            children: [
              Expanded(
                child: CustomTextCard(
                  text: customer.phone!,
                  hint: LocaleKey.phone.tr,
                ),
              ),
              const SizedBox(width: Constants.spaceWith10x),
              Expanded(
                child: CustomTextCard(
                  text: customer.currency!.split('-')[1].trim(),
                  hint: LocaleKey.currency.tr,
                ),
              ),
            ],
          ),
          if (customer.address!.isNotEmpty) ...[
            CustomTextCard(
              text: customer.address!,
              hint: LocaleKey.address.tr,
            ),
          ],
          Row(
            children: [
              Expanded(
                child: CustomTextCard(
                  text: '${customer.totalGivenAmount.toString()}'
                      '.${customer.currency!.split('-')[0].trim()}',
                  hint: LocaleKey.gave.tr,
                  color: CupertinoColors.systemRed.withOpacity(.1),
                  textColor: CupertinoColors.systemRed,
                ),
              ),
              const SizedBox(width: Constants.spaceWith10x),
              Expanded(
                child: CustomTextCard(
                  text: '${customer.totalGottenAmount.toString()}'
                      '.${customer.currency!.split('-')[0].trim()}',
                  hint: LocaleKey.got.tr,
                  color: CupertinoColors.systemGreen.withOpacity(.1),
                  textColor: CupertinoColors.systemGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
