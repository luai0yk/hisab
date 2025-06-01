import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/card/custom_text_card.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/localization/locale_key.dart';
import '../model/customer_model.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerModel customer = Get.arguments!;
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: '${customer.name!.split(' ')[0]} ${LocaleKey.profile}',
        // actions: [
        //   CustomIconButton(
        //     onPressed: () => Get.back(),
        //     toolTip: LocaleKey.close.tr,
        //     icon: HugeIcons.strokeRoundedMultiplicationSign,
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.spaceWith15x),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Jiffy.parse(customer.addedAt!).fromNow(),
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
                      text: customer.currency!,
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
                      text: '867,60',
                      hint: LocaleKey.got.tr,
                      color: CupertinoColors.systemRed.withOpacity(.1),
                      textColor: CupertinoColors.systemRed,
                    ),
                  ),
                  const SizedBox(width: Constants.spaceWith10x),
                  Expanded(
                    child: CustomTextCard(
                      text: '777,50',
                      hint: LocaleKey.gave.tr,
                      color: CupertinoColors.systemGreen.withOpacity(.1),
                      textColor: CupertinoColors.systemGreen,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      text: 'Edit',
                    ),
                  ),
                  const SizedBox(width: Constants.spaceWith15x),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      text: 'view',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
