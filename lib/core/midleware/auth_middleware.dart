import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/constants.dart';
import 'package:hisab/core/route/app_routes.dart';
import 'package:hisab/main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isLoggedIn = prefs!.getBool(Constants.isLoggedIn) ?? false;

    if (isLoggedIn) {
      return const RouteSettings(name: AppRoutes.homePage);
    }

    return null;
  }
}
