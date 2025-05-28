import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hisab/features/auth/sign_up.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUp(),
    ),
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => Login(),
    // ),
  ];
}
