import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/db/customer/add_customer_db.dart';
import 'package:hisab/core/db/customer/delete_customer_db.dart';
import 'package:hisab/core/db/customer/edit_customer_db.dart';
import 'package:hisab/core/db/customer/view_customer_db.dart';

import '../../../core/services/storage_service.dart';
import '../../../shared/model/customer_model.dart';

class CustomerController extends GetxController {
  // Input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleSelectController<String> currencyController =
      SingleSelectController('YER - Yemeni Rial');

  TextEditingController searchController = TextEditingController();

  // Customer data
  List<CustomerModel>? _originList;
  List<CustomerModel>? _filteredList;

  List<CustomerModel>? get filteredList => _filteredList;

  @override
  void onInit() {
    super.onInit();
    viewCustomers(); // load initial data

    searchController.addListener(() {
      searchCustomer(searchController.text);
    });
  }

  // Load data into controllers for editing
  void loadDataForEdit(CustomerModel customer) {
    currencyController = SingleSelectController(customer.currency);
    nameController.text = customer.name!;
    phoneController.text = customer.phone!;
    addressController.text = customer.address!;
  }

  // Clear input fields
  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    currencyController = SingleSelectController('YER - Yemeni Rial');
  }

  // Get customers from DB
  Future<void> viewCustomers() async {
    final storage = Get.find<StorageService>();
    _originList = await ViewCustomerDB.instance.viewCustomers(
      userId: storage.getInt(StorageKey.userID)!,
      query: '',
    );
    _filteredList = _originList;
    update(['customer_list']); // refresh UI
  }

  // Add new customer
  Future<void> addCustomer() async {
    final db = AddCustomerDB.instance;

    if (await db.isPhoneUsed(phone: phoneController.text.trim())) {
      Get.snackbar('Error', 'Phone number is already used',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final storage = Get.find<StorageService>();
    final newCustomer = CustomerModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      currency: currencyController.value,
      addedAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      isSynced: false,
      userID: storage.getInt(StorageKey.userID),
    );

    await db.addedCustomer(customer: newCustomer);
    await viewCustomers(); // refresh list
    Get.back();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Edit existing customer
  Future<void> editCustomer(int id) async {
    await EditCustomerDB.instance.editCustomer(
      customerId: id,
      customer: CustomerModel(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        currency: currencyController.value,
        updatedAt: DateTime.now().toString(),
      ),
    );

    await viewCustomers(); // refresh list
    Get.back();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Delete customer
  Future<void> deleteCustomer(int id) async {
    await DeleteCustomerDB().deleteCustomer(customerID: id);
    await viewCustomers(); // refresh list
  }

  // Filter customers locally
  void searchCustomer(String query) {
    if (_originList == null) return;

    if (query.isEmpty) {
      _filteredList = _originList;
    } else {
      _filteredList = _originList!
          .where((c) => c.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update(['customer_list']); // update UI
  }
}
