import 'package:get/get.dart';
import 'package:hisab/core/db/view_customer_db.dart';
import 'package:hisab/features/hisab/customers/model/customer_model.dart';

class ViewCustomerController extends GetxController {
  List<CustomerModel>? customerList;

  Future<void> viewCustomers() async {
    ViewCustomerDB customer = ViewCustomerDB.instance;
    customerList = await customer.viewCustomers();
    update(['customer_list']);
  }
}
