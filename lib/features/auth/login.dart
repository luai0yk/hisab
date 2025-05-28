// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hisab/core/constants/constants.dart';
// import 'package:hisab/core/route/app_routes.dart';
// import 'package:hisab/core/validator/input_validator.dart';
// import 'package:hisab/shared/widgets/button/custom_button.dart';
// import 'package:hisab/shared/widgets/input/custom_text_form_field.dart';
//
// import '../../core/constants/theme/custom_theme/custom_text_theme.dart';
// import '../../core/localization/translation_key.dart';
//
// class Login extends StatelessWidget {
//   final GlobalKey<FormState> formState = GlobalKey<FormState>();
//
//   Login({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 8,
//             ),
//             Form(
//               key: formState,
//               child: Container(
//                 padding: const EdgeInsets.all(Constants.x8Space),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       TranslationKey.login.tr,
//                       style: CustomTextTheme.textStyle.copyWith(
//                         fontSize: Constants.size40,
//                       ),
//                     ),
//                     const SizedBox(height: Constants.x8Space),
//                     CustomTextFormField(
//                       hint: TranslationKey.email.tr,
//                       icon: Icons.email_outlined,
//                       maxLength: 25,
//                       validator: (value) => InputValidator.validateInput(
//                         value: value!,
//                         validateEmail: true,
//                         fieldName: 'Email',
//                       ),
//                     ),
//                     CustomTextFormField(
//                       hint: TranslationKey.password.tr,
//                       icon: Icons.password_outlined,
//                       maxLength: 15,
//                       obscureText: true,
//                       validator: (value) => InputValidator.validateInput(
//                         min: 6,
//                         value: value!,
//                         fieldName: TranslationKey.password.tr,
//                       ),
//                     ),
//                     const SizedBox(height: Constants.x6Space),
//                     CustomButton(
//                       text: TranslationKey.login.tr,
//                       onPressed: () {
//                         if (formState.currentState!.validate()) {}
//                       },
//                     ),
//                     const SizedBox(height: Constants.x2Space),
//                     RichText(
//                       text: TextSpan(
//                         style: CustomTextTheme.textStyle,
//                         children: [
//                           TextSpan(
//                             text: '    ${TranslationKey.createAccount.tr}, ',
//                           ),
//                           WidgetSpan(
//                             child: InkWell(
//                               onTap: () => Get.toNamed(AppRoutes.signup),
//                               child: Text(
//                                 TranslationKey.signup.tr,
//                                 style: TextStyle(
//                                   color: Get.theme.colorScheme.primary,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
