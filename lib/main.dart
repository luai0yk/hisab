import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hisab/core/constants/theme/dark_theme.dart';
import 'package:hisab/core/constants/theme/light_theme.dart';
import 'package:hisab/core/route/app_pages.dart';
import 'package:jiffy/jiffy.dart';

import 'core/localization/app_translation.dart';
import 'core/services/storage_service.dart';

// SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //prefs = await SharedPreferences.getInstance();
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  await Get.putAsync<StorageService>(
    () async => await StorageService().init(),
  );
  await Jiffy.setLocale('en');
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
      locale: const Locale('en'),
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
