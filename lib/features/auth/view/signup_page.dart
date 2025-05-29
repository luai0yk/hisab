import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/core/validator/input_validator.dart';
import 'package:hisab/features/auth/controllers/signup_controller.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../../core/localization/locale_key.dart';

class SignupPage extends GetView<SignupController> {
  SignupPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Constants.spaceWith20x),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      LocaleKey.signup.tr,
                      style: CustomTextTheme.textStyle.copyWith(
                        fontSize: Constants.size40,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.spaceWith20x),
                  CustomTextFormField(
                    controller: controller.fullNameController,
                    hint: LocaleKey.fullName.tr,
                    icon: HugeIcons.strokeRoundedUser,
                    maxLength: 25,
                    validator: (value) => InputValidator.validateInput(
                      min: 6,
                      value: value!,
                      fieldName: LocaleKey.fullName.tr,
                    ),
                  ),
                  const SizedBox(height: Constants.spaceWith10x),
                  CustomTextFormField(
                    controller: controller.emailController,
                    hint: LocaleKey.email.tr,
                    icon: HugeIcons.strokeRoundedMail01,
                    maxLength: 25,
                    validator: (value) => InputValidator.validateInput(
                      value: value!,
                      validateEmail: true,
                      fieldName: LocaleKey.email.tr,
                    ),
                  ),
                  const SizedBox(height: Constants.spaceWith10x),
                  CustomTextFormField(
                    controller: controller.passwordController,
                    hint: LocaleKey.password.tr,
                    icon: HugeIcons.strokeRoundedSquareLockPassword,
                    maxLength: 15,
                    obscureText: true,
                    validator: (value) => InputValidator.validateInput(
                      min: 6,
                      value: value!,
                      fieldName: LocaleKey.password.tr,
                    ),
                  ),
                  const SizedBox(height: Constants.spaceWith20x),
                  GetBuilder<SignupController>(
                    id: 'signup_button',
                    builder: (controller) {
                      return CustomButton(
                        text:
                            controller.isLoading ? '...' : LocaleKey.signup.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.signUp();
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Constants.spaceWith4x),
                  RichText(
                    text: TextSpan(
                      style: CustomTextTheme.textStyle,
                      children: [
                        TextSpan(
                          text: '    ${LocaleKey.haveAccount.tr} ',
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Get.offAllNamed(AppRoutes.loginPage),
                            child: Text(
                              LocaleKey.login.tr,
                              style: TextStyle(
                                color: Constants.primaryColor,
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
          ],
        ),
      ),
    );
  }
}
