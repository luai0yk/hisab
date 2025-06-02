import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/color_extension.dart';
import 'package:hisab/core/constants/theme/custom_theme/custom_text_theme.dart';
import 'package:hisab/features/transactions/controller/add_transaction_controller.dart';
import 'package:hisab/features/transactions/widget/custom_drop_down.dart';
import 'package:hisab/shared/widgets/button/custom_icon_button.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/localization/locale_key.dart';
import '../../../core/validator/input_validator.dart';
import '../../../shared/widgets/button/custom_button.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/input/custom_text_form_field.dart';

class AddTransactionPage extends GetWidget<AddTransactionController> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorExtension customColors = Get.theme.extension<ColorExtension>()!;

    return Scaffold(
      appBar: CustomAppbar.appBar(
        title: LocaleKey.addTransaction.tr,
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
                    controller: controller.amountController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: Constants.maxLengthAmount,
                    validator: (value) {
                      return InputValidator.validateInput(
                        value: value!,
                        fieldName: LocaleKey.amount.tr,
                      );
                    },
                    hint: LocaleKey.amount.tr,
                    textInputType: TextInputType.number,
                    icon: HugeIcons.strokeRoundedMoney03,
                  ),
                  CustomTextFormField(
                    controller: controller.descriptionController,
                    maxLength: Constants.maxLengthDescription,
                    hint: LocaleKey.description.tr,
                    icon: HugeIcons.strokeRoundedTextAlignCenter,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                          controller: controller.typeController,
                          items: const ['gave', 'got'],
                        ),
                      ),
                      const SizedBox(width: Constants.spaceWith15x),
                      Expanded(
                        child: CustomTextFormField(
                          controller: controller.dateController,
                          onTap: () {
                            setDate(
                              context: context,
                              customColors: customColors,
                            );
                          },
                          readOnly: true,
                          hint: LocaleKey.date.tr,
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
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  await controller.addTransaction();
                }
              },
              text: LocaleKey.addTransaction.tr,
            ),
          ],
        ),
      ),
    );
  }

  void setDate({context, customColors}) {
    BottomPicker.date(
      pickerTitle: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.spaceWith10x,
        ),
        child: Text(
          'Transaction Date',
          style: CustomTextTheme.textStyle.copyWith(
            fontSize: 22,
          ),
        ),
      ),
      initialDateTime: DateTime.now(),
      pickerTextStyle: CustomTextTheme.textStyle.copyWith(
        fontSize: 18,
      ),
      backgroundColor: customColors.surfaceColor,
      onChange: (index) {
        controller.setDateTime(dateTime: index);
      },
      minDateTime: DateTime(2050, 1, 1),
      maxDateTime: DateTime(2030, 1, 1),
      displaySubmitButton: false,
      buttonStyle: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(
          Constants.radius,
        ),
      ),
      buttonWidth: 300,
      closeWidget: CustomIconButton(
        icon: HugeIcons.strokeRoundedMultiplicationSign,
        toolTip: LocaleKey.close.tr,
        onPressed: () => Get.back(),
      ),
    ).show(context);
  }
}
