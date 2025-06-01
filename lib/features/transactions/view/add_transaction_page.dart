import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/localization/locale_key.dart';
import '../../../core/validator/input_validator.dart';
import '../../../shared/widgets/button/custom_button.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/input/custom_text_form_field.dart';

class AddTransactionPage extends StatelessWidget {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final SingleSelectController<String> typeController =
      SingleSelectController('Got');

  AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: 'add transaction',
      ),
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
                    //controller: controller.nameController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 9,
                    validator: (value) {
                      return InputValidator.validateInput(
                        value: value!,
                        min: Constants.minNameLength,
                        fieldName: LocaleKey.amount.tr,
                      );
                    },
                    hint: LocaleKey.amount.tr,
                    textInputType: TextInputType.number,

                    icon: HugeIcons.strokeRoundedMoney03,
                  ),
                  CustomTextFormField(
                    // controller: controller.addressController,
                    maxLength: 50,
                    hint: LocaleKey.description.tr,
                    icon: HugeIcons.strokeRoundedTextAlignCenter,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          //controller: controller.phoneController,
                          maxLength: Constants.maxLengthPhone,

                          readOnly: true,
                          hint: LocaleKey.type.tr,
                          textInputType: TextInputType.phone,
                          icon: HugeIcons.strokeRoundedTransaction,
                        ),
                      ),
                      const SizedBox(width: Constants.spaceWith15x),
                      Expanded(
                        child: CustomTextFormField(
                          //controller: controller.phoneController,
                          maxLength: Constants.maxLengthPhone,

                          readOnly: true,
                          hint: LocaleKey.date.tr,
                          textInputType: TextInputType.phone,
                          icon: HugeIcons.strokeRoundedDateTime,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                if (formState.currentState!.validate()) {
                  //controller.addCustomer();
                }
              },
              text: LocaleKey.addTransaction.tr,
            ),
          ],
        ),
      ),
    );
  }
}
