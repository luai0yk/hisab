import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/storage_key.dart';
import 'package:hisab/core/route/app_routes.dart';

import '../services/storage_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storage = Get.find<StorageService>();

    bool isLoggedIn = storage.getBool(StorageKey.isUserLogged) ?? false;

    if (isLoggedIn) {
      return const RouteSettings(name: AppRoutes.viewCustomerPage);
    }

    return null;
  }
}
