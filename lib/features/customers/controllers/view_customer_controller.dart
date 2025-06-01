import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/db/view_customer_db.dart';

import '../../../core/services/storage_service.dart';
import '../model/customer_model.dart';

class ViewCustomerController extends GetxController {
  List<CustomerModel>? _originList, _filteredList;

  TextEditingController searchController = TextEditingController();

  Future<void> viewCustomers() async {
    ViewCustomerDB customer = ViewCustomerDB.instance;
    final storage = Get.find<StorageService>();

    _originList = await customer.viewCustomers(
        userId: storage.getString(StorageKey.userID)!);
    _filteredList = _originList;
    update(['customer_list']);
  }

  List<CustomerModel>? get customerList => _filteredList;

  void searchCustomer({required String query}) {
    if (query.isEmpty) {
      _filteredList = _originList;
    } else {
      _filteredList = _originList!.where(
        (element) {
          return element.name!.contains(query.toLowerCase());
        },
      ).toList();
    }

    update(['customer_list']);
  }
}
