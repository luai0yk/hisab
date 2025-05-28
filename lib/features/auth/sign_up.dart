import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/core/validator/input_validator.dart';
import 'package:hisab/features/auth/controllers/signup_controller.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';

import '../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../core/localization/translation_key.dart';

class SignUp extends GetView<SignupController> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  SignUp({super.key});

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
            Form(
              key: formState,
              child: Container(
                padding: const EdgeInsets.all(Constants.x8Space),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      TranslationKey.signup.tr,
                      style: CustomTextTheme.textStyle.copyWith(
                        fontSize: Constants.size40,
                      ),
                    ),
                    const SizedBox(height: Constants.x8Space),
                    CustomTextFormField(
                      controller: controller.fullNameController,
                      hint: TranslationKey.fullName.tr,
                      icon: Icons.person_outline,
                      maxLength: 25,
                      validator: (value) => InputValidator.validateInput(
                        min: 6,
                        value: value!,
                        fieldName: TranslationKey.fullName.tr,
                      ),
                    ),
                    CustomTextFormField(
                      controller: controller.emailController,
                      hint: TranslationKey.email.tr,
                      icon: Icons.email_outlined,
                      maxLength: 25,
                      validator: (value) => InputValidator.validateInput(
                        value: value!,
                        validateEmail: true,
                        fieldName: 'Email',
                      ),
                    ),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hint: TranslationKey.password.tr,
                      icon: Icons.password_outlined,
                      maxLength: 15,
                      obscureText: true,
                      validator: (value) => InputValidator.validateInput(
                        min: 6,
                        value: value!,
                        fieldName: TranslationKey.password.tr,
                      ),
                    ),
                    const SizedBox(height: Constants.x6Space),
                    CustomButton(
                      text: TranslationKey.signup.tr,
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          await controller.signUp();
                        }
                      },
                    ),
                    const SizedBox(height: Constants.x2Space),
                    RichText(
                      text: TextSpan(
                        style: CustomTextTheme.textStyle,
                        children: [
                          TextSpan(
                            text: '    ${TranslationKey.haveAccount.tr}, ',
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () => Get.toNamed(AppRoutes.login),
                              child: Text(
                                TranslationKey.login.tr,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
