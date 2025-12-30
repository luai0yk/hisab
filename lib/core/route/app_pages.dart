import 'package:get/get.dart';
import 'package:hisab/features/customers/view/edit_customer_page.dart';
import 'package:hisab/features/customers/view/view_customer_page.dart';
import 'package:hisab/features/transactions/controller/transaction_controller.dart';
import 'package:hisab/features/transactions/view/add_transaction_page.dart';
import 'package:hisab/features/transactions/view/edit_transaction_page.dart';
import 'package:hisab/shared/controller/customer_data_controller.dart';

import '../../features/customers/controllers/customer_controller.dart';
import '../../features/customers/view/add_customer_page.dart';
import '../../features/customers/view/customer_profile_page.dart';
import '../../features/transactions/view/view_transaction_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.viewCustomerPage,
      page: () => const ViewCustomerPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => CustomerController(),
          );
          Get.lazyPut(
            () => CustomerDataController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.addCustomerPage,
      page: () => AddCustomerPage(),
    ),
    GetPage(
      name: AppRoutes.transactionPage,
      page: () => ViewTransactionPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => TransactionController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.addTransactionPage,
      page: () => AddTransactionPage(),
    ),
    GetPage(
      name: AppRoutes.customerProfilePage,
      page: () => CustomerProfilePage(),
    ),
    GetPage(
      name: AppRoutes.editCustomerPage,
      page: () => EditCustomerPage(),
    ),
    GetPage(
      name: AppRoutes.editTransactionPage,
      page: () => EditTransactionPage(),
    ),
  ];
}
