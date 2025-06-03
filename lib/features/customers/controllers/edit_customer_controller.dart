import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/db/customer/edit_customer_db.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';
import 'package:hisab/shared/model/customer_model.dart';

class EditCustomerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleSelectController<String>? currencyController;
  late CustomerModel customer;
  @override
  void onInit() {
    customer = Get.find<CustomerDataController>().customer;
    currencyController = SingleSelectController(customer.currency);
    nameController.text = customer.name!;
    phoneController.text = customer.phone!;
    addressController.text = customer.address!;
    super.onInit();
  }

  Future<void> editCustomer() async {
    customer = CustomerModel(
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      currency: currencyController!.value,
      updatedAt: DateTime.now().toString(),
    );
    await EditCustomerDB.instance.editCustomer(
      customer: customer,
    );
    update();
    Get.back();
  }
}
