import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/card/custom_text_card.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';

import '../../../../core/localization/locale_key.dart';

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
              // CustomAppbar(
              //   title:
              //       '${customer.name!.split(' ')[0]} ${LocaleKey.profile.tr}',
              //   actions: [
              //     CustomIconButton(
              //       onPressed: () => Get.back(),
              //       toolTip: LocaleKey.close.tr,
              //       icon: HugeIcons.strokeRoundedMultiplicationSign,
              //     )
              //   ],
              // ),
              const SizedBox(height: Constants.spaceWith20x),
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
              const SizedBox(height: Constants.spaceWith20x),
              CustomTextCard(text: customer.phone!),
              CustomTextCard(text: customer.currency!),
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
