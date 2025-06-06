import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/db/customer/view_customer_db.dart';
import 'package:hisab/core/services/storage_service.dart';
import 'package:hisab/shared/model/customer_model.dart';

class CustomerDataController extends GetxController {
  late CustomerModel customer;

  Future<void> viewCustomerById() async {
    final storage = Get.find<StorageService>();

    ViewCustomerDB customerDB = ViewCustomerDB.instance;
    customer = await customerDB.viewCustomerByID(
      userId: storage.getInt(StorageKey.userID)!,
      customerId: customer.id!,
    );

    update(['customer_profile']);
  }
}
