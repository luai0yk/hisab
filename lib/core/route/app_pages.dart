import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hisab/features/auth/view/signup_page.dart';
import 'package:hisab/features/hisab/customers/view/add_customer_page.dart';
import 'package:hisab/features/hisab/customers/view/customer_profile_page.dart';
import 'package:hisab/features/hisab/home.dart';

import '../../features/auth/view/login_page.dart';
import '../midleware/auth_middleware.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.signupPage,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.addCustomerPage,
      page: () => AddCustomerPage(),
    ),
    GetPage(
      name: AppRoutes.customerProfilePage,
      page: () => CustomerProfilePage(),
    ),
  ];
}
