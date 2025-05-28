import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/services/api_services.dart';
import 'package:hisab/features/auth/model/user_model.dart';

import '../../../core/constants/api_links.dart';
import '../../../core/constants/constants.dart';
import '../../../core/route/app_routes.dart';

class SignupController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signUp() async {
    _isLoading = true;
    update(['signup_button']);

    Map userData = UserModel(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    ).toJson();

    final response = await ApiServices.postRequest(
      url: ApiLinks.signUpLink,
      data: userData,
    );

    _isLoading = false;
    update(['signup_button']);

    final status = response['status'];
    final message = response['message'];

    if (status == Constants.statusSuccess) {
      Get.offAllNamed(AppRoutes.loginPage);
    } else if (status == Constants.statusError) {
      Get.snackbar(status, message, snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar(status, status, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
