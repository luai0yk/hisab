import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';

import '../../core/localization/translation_key.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Container(
              padding: const EdgeInsets.all(Constants.x8Space),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    TranslationKey.signup.tr,
                    style: textStyle,
                  ),
                  const SizedBox(height: Constants.x8Space),
                  CustomTextFormField(
                    hint: TranslationKey.name.tr,
                  ),
                  CustomTextFormField(
                    hint: TranslationKey.email.tr,
                  ),
                  CustomTextFormField(
                    hint: TranslationKey.password.tr,
                  ),
                  const SizedBox(height: Constants.x6Space),
                  CustomButton(
                    text: TranslationKey.signup.tr,
                    onPressed: () {},
                  ),
                  const InkWell(
                    child: Text(
                      'I have an account, login',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle get textStyle {
  return const TextStyle(
    fontSize: Constants.x6Size,
    fontWeight: FontWeight.w600,
  );
}
