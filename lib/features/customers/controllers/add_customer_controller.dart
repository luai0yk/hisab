import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';

import '../../../../core/db/add_customer_db.dart';
import '../../../core/services/storage_service.dart';
import '../model/customer_model.dart';

class AddCustomerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleSelectController<String> currencyController =
      SingleSelectController('YER - Yemeni Rial');

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    currencyController.dispose();
    super.dispose();
  }

  Future<void> addCustomer() async {
    AddCustomerDB addCustomer = AddCustomerDB.instance;
    bool isPhoneUsed = await addCustomer.isPhoneUsed(
      phone: phoneController.text,
    );
    if (isPhoneUsed) {
      Get.snackbar(
        'Error',
        'Phone number is already used',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final storage = Get.find<StorageService>();

      await addCustomer.addedCustomer(
        customer: CustomerModel(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          currency: currencyController.value,
          isSynced: false,
          userID: storage.getString(StorageKey.userID),
        ),
      );
      Get.back();
    }
  }
}
