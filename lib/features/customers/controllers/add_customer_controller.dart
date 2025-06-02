import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';

import '../../../../core/db/add_customer_db.dart';
import '../../../core/services/storage_service.dart';
import '../../../shared/model/customer_model.dart';

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
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          address: addressController.text.trim(),
          currency: currencyController.value,
          addedAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString(),
          isSynced: false,
          userID: storage.getString(StorageKey.userID),
        ),
      );
      Get.back();
    }
  }

  final List<String> arabCurrencies = [
    'USD - United States Dollar',
    'EUR - Euro',
    'SAR - Saudi Riyal',
    'AED - UAE Dirham',
    'EGP - Egyptian Pound',
    'IQD - Iraqi Dinar',
    'YER - Yemeni Rial',
    'KWD - Kuwaiti Dinar',
    'QAR - Qatari Riyal',
    'OMR - Omani Rial',
    'BHD - Bahraini Dinar',
    'LYD - Libyan Dinar',
    'SYP - Syrian Pound',
    'DZD - Algerian Dinar',
    'TND - Tunisian Dinar',
    'MAD - Moroccan Dirham',
    'SDG - Sudanese Pound',
    'MRU - Mauritanian Ouguiya',
  ];
}
