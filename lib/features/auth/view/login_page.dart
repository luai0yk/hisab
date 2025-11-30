import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/core/services/storage_service.dart';
import 'package:hisab/core/validator/input_validator.dart';
import 'package:hisab/features/auth/controllers/login_controller.dart';
import 'package:hisab/shared/widgets/button/custom_button.dart';
import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/constants/theme/custom_theme/custom_text_theme.dart';
import '../../../core/localization/locale_key.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Constants.spaceWith15x),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      LocaleKey.login.tr,
                      style: CustomTextTheme.textStyle.copyWith(
                        fontSize: Constants.size40,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.spaceWith20x),
                  CustomTextFormField(
                    hint: LocaleKey.email.tr,
                    icon: HugeIcons.strokeRoundedMail01,
                    maxLength: 25,
                    validator: (value) => InputValidator.validateInput(
                      value: value!,
                      validateEmail: true,
                      fieldName: LocaleKey.email.tr,
                    ),
                    controller: controller.emailController,
                  ),
                  CustomTextFormField(
                    hint: LocaleKey.password.tr,
                    icon: HugeIcons.strokeRoundedSquareLockPassword,
                    maxLength: 15,
                    obscureText: true,
                    validator: (value) => InputValidator.validateInput(
                      min: 6,
                      value: value!,
                      fieldName: LocaleKey.password.tr,
                    ),
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: Constants.spaceWith20x),
                  GetBuilder<LoginController>(
                    id: 'login_button',
                    builder: (controller) {
                      return CustomButton(
                        text: controller.isLoading ? '...' : LocaleKey.login.tr,
                        onPressed: () async {
                          StorageService storage = Get.find<StorageService>();
                          storage.setInt(StorageKey.userID, 1);
                          storage.setBool(StorageKey.isUserLogged, true);
                          Get.offAllNamed(AppRoutes.customerPage);
                          // if (_formKey.currentState!.validate()) {
                          // await controller.login();
                          // }
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
                          text: '    ${LocaleKey.createAccount.tr} ',
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.signupPage);
                            },
                            child: Text(
                              LocaleKey.signup.tr,
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
