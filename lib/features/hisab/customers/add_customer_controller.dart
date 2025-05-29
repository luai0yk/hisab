import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleSelectController<String> currencyController =
      SingleSelectController('YER - Yemeni Rial');
}
