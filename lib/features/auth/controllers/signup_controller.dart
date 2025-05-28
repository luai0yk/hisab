import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/services/api_services.dart';

import '../../../core/constants/api_links.dart';

class SignupController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp() async {
    await ApiServices.postRequest(url: ApiLinks.signUpLink, data: {
      'name': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
  }
}
