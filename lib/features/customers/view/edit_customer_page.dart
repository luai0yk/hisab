import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/localization/locale_key.dart';
import 'package:hisab/core/validator/input_validator.dart';
import 'package:hisab/features/customers/controllers/customer_controller.dart';
import 'package:hisab/shared/model/customer_model.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../widget/custom_currency_drop_down.dart';

class EditCustomerPage extends GetView<CustomerController> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CustomerModel customer = Get.arguments;
  EditCustomerPage({super.key}) {
    controller.loadDataForEdit(customer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(title: LocaleKey.editCustomer.tr),
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  CustomCurrencyDropDown(
                    controller: controller.currencyController!,
                    items: Constants.arabCurrencies,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                if (formState.currentState!.validate()) {
                  controller.editCustomer(customer.id!);
                }
              },
              text: LocaleKey.editCustomer.tr,
            ),
          ],
        ),
      ),
    );
  }
}
