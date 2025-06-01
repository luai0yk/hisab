import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/validator/input_validator.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/input/custom_drop_down_menu.dart';
import '../controllers/add_customer_controller.dart';

class AddCustomerPage extends GetView<AddCustomerController> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(title: LocaleKey.addCustomer.tr),
      body: Padding(
        padding: const EdgeInsets.all(Constants.spaceWith15x),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: controller.nameController,
                    maxLength: Constants.maxNameLength,
                    validator: (value) {
                      return InputValidator.validateInput(
                        value: value!,
                        min: Constants.minNameLength,
                        fieldName: LocaleKey.customerName.tr,
                      );
                    },
                    hint: LocaleKey.customerName.tr,
                    icon: HugeIcons.strokeRoundedUser,
                  ),
                  CustomTextFormField(
                    controller: controller.phoneController,
                    maxLength: Constants.maxLengthPhone,
                    validator: (value) {
                      return InputValidator.validateInput(
                        value: value!,
                        min: Constants.minLengthPhone,
                        fieldName: LocaleKey.phoneNumber.tr,
                      );
                    },
                    hint: LocaleKey.phoneNumber.tr,
                    textInputType: TextInputType.phone,
                    icon: HugeIcons.strokeRoundedTelephone,
                  ),
                  CustomTextFormField(
                    controller: controller.addressController,
                    hint: LocaleKey.address.tr,
                    icon: HugeIcons.strokeRoundedLocation01,
                  ),
                  CustomDropDownMenu(
                    controller: controller.currencyController,
                    items: arabCurrencies,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                if (formState.currentState!.validate()) {
                  controller.addCustomer();
                }
              },
              text: LocaleKey.addCustomer.tr,
            ),
          ],
        ),
      ),
    );
  }

  final List<String> arabCurrencies = [
    'USD - United States Dollar',
    'EUR - Euro',
    'SAR - Saudi Riyal',
    'AED - UAE Dirham',
    'EGP - Egyptian Pound',
    'IQD - Iraqi Dinar',
    'YER - Yemeni Rial',
    'KWD - Kuwaiti Dinar',
    'QAR - Qatari Riyal',
    'OMR - Omani Rial',
    'BHD - Bahraini Dinar',
    'LYD - Libyan Dinar',
    'SYP - Syrian Pound',
    'DZD - Algerian Dinar',
    'TND - Tunisian Dinar',
    'MAD - Moroccan Dirham',
    'SDG - Sudanese Pound',
    'MRU - Mauritanian Ouguiya',
  ];
}
