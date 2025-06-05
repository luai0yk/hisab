import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_hint_style.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';
import 'package:hisab/shared/widgets/card/custom_text_card.dart';
import 'package:hisab/shared/widgets/custom_appbar.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/localization/locale_key.dart';
import '../../../core/db/customer/delete_customer_db.dart';
import '../../../core/route/app_routes.dart';
import '../../../shared/widgets/button/custom_button.dart';

class CustomerProfilePage extends GetView<CustomerDataController> {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: '${controller.customer.name!.split(' ')[0]}'
            '${LocaleKey.profile.tr}',
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CustomerDataController>(
              id: 'customer_profile',
              initState: (state) async => await controller.viewCustomerById(),
              builder: (controller) {
                return ListView(
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
                        controller.customer.name!.substring(0, 1).toUpperCase(),
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
                        controller.customer.name!.toUpperCase(),
                        style: CustomTextTheme.textStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        Jiffy.parse(controller.customer.addedAt!)
                            .format(pattern: 'dd/MMM/yyyy'),
                        style: CustomHintStyle.hintStyle,
                      ),
                    ),
                    const SizedBox(height: Constants.spaceWith20x),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextCard(
                            text: controller.customer.phone!,
                            hint: LocaleKey.phone.tr,
                          ),
                        ),
                        const SizedBox(width: Constants.spaceWith10x),
                        Expanded(
                          child: CustomTextCard(
                            text: controller.customer.currency!
                                .split('-')[1]
                                .trim(),
                            hint: LocaleKey.currency.tr,
                          ),
                        ),
                      ],
                    ),
                    if (controller.customer.address!.isNotEmpty) ...[
                      CustomTextCard(
                        text: controller.customer.address!,
                        hint: LocaleKey.address.tr,
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextCard(
                            text:
                                '${controller.customer.totalGivenAmount.toInt().toString()}'
                                '.${controller.customer.currency!.split('-')[0].trim()}',
                            hint: LocaleKey.gave.tr,
                            color: CupertinoColors.systemRed.withOpacity(.1),
                            textColor: CupertinoColors.systemRed,
                          ),
                        ),
                        const SizedBox(width: Constants.spaceWith10x),
                        Expanded(
                          child: CustomTextCard(
                            text:
                                '${controller.customer.totalGottenAmount.toInt().toString()}'
                                '.${controller.customer.currency!.split('-')[0].trim()}',
                            hint: LocaleKey.got.tr,
                            color: CupertinoColors.systemGreen.withOpacity(.1),
                            textColor: CupertinoColors.systemGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.spaceWith15x),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () async {
                      Get.toNamed(AppRoutes.editCustomerPage)!.then(
                        (value) async {
                          await controller.viewCustomerById();
                        },
                      );
                    },
                    text: LocaleKey.edit.tr,
                  ),
                ),
                const SizedBox(width: Constants.spaceWith15x),
                Expanded(
                  child: CustomButton(
                    color: CupertinoColors.systemRed,
                    onPressed: () async {
                      await DeleteCustomerDB().deleteCustomer(
                        customerID: controller.customer.id,
                      );
                      Get.back();
                      Get.back();
                    },
                    text: LocaleKey.delete.tr,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
