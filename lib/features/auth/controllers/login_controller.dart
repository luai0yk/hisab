import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/main.dart';

import '../../../core/constants/api_links.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/api_services.dart';
import '../model/user_model.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    _isLoading = true;
    update(['login_button']);

    Map userInput = UserModel(
      email: emailController.text,
      password: passwordController.text,
    ).toJson();

    final response = await ApiServices.postRequest(
      url: ApiLinks.loginLink,
      data: userInput,
    );

    _isLoading = false;
    update(['login_button']);

    final status = response['status'];
    final message = response['message'];

    if (status == Constants.statusSuccess) {
      final UserModel userData = UserModel.fromJson(response['data']);
      prefs!.setBool(Constants.isLoggedIn, true);
      prefs!.setString('user_id', userData.id);
      prefs!.setString(Constants.fullName, userData.fullName);
      prefs!.setString(Constants.email, userData.email!);
      Get.offAllNamed(AppRoutes.customerPage);
    } else if (status == Constants.statusError) {
      Get.snackbar(status, message, snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar(status, status, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
