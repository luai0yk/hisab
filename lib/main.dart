import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/dark_theme.dart';
import 'package:hisab/core/constants/theme/light_theme.dart';
import 'package:hisab/core/route/app_pages.dart';
import 'package:hisab/features/auth/controllers/login_controller.dart';
import 'package:hisab/features/hisab/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/app_translation.dart';
import 'features/auth/controllers/signup_controller.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  Get.put(SignupController());
  Get.put(LoginController());
  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme.light,
      darkTheme: DarkTheme.dark,
      themeMode: ThemeMode.light,
      translations: AppTranslations(),
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: AppPages.routes,
    );
  }
}
