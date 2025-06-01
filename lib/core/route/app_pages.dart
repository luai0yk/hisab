import 'package:get/get.dart';
import 'package:hisab/features/auth/controllers/login_controller.dart';
import 'package:hisab/features/auth/view/signup_page.dart';
import 'package:hisab/features/home/controller/home_controller.dart';
import 'package:hisab/features/home/view/home_page.dart';
import 'package:hisab/features/transactions/view/add_transaction_page.dart';

import '../../features/auth/controllers/signup_controller.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/customers/controllers/add_customer_controller.dart';
import '../../features/customers/controllers/view_customer_controller.dart';
import '../../features/customers/view/add_customer_page.dart';
import '../../features/customers/view/customer_profile_page.dart';
import '../../features/transactions/view/view_transaction_page.dart';
import '../midleware/auth_middleware.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.signupPage,
      page: () => SignupPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => SignupController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => LoginController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => HomeController(),
          );
          Get.lazyPut(
            () => ViewCustomerController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.addCustomerPage,
      page: () => AddCustomerPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => AddCustomerController(),
          );
        },
      ),
    ),
    GetPage(
      name: AppRoutes.transactionPage,
      page: () => ViewTransactionPage(),
    ),
    GetPage(
      name: AppRoutes.addTransactionPage,
      page: () => AddTransactionPage(),
    ),
    GetPage(
      name: AppRoutes.customerProfilePage,
      page: () => CustomerProfilePage(),
    ),
  ];
}
