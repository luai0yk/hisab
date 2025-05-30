import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/db/view_customer_db.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';
import 'package:hisab/main.dart';

class ViewCustomerController extends GetxController {
  List<CustomerModel>? _originList, _filteredList;

  TextEditingController searchController = TextEditingController();

  Future<void> viewCustomers() async {
    ViewCustomerDB customer = ViewCustomerDB.instance;
    _originList =
        await customer.viewCustomers(userId: prefs!.getString('user_id')!);
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
