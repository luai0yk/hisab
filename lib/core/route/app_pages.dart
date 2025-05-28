import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hisab/features/auth/view/signup_page.dart';
import 'package:hisab/features/customers/view/customer_page.dart';

import '../../features/auth/view/login_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.signupPage,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.customerPage,
      page: () => const CustomerPage(),
    ),
  ];
}
