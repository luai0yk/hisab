import 'package:get/get.dart';
import 'package:hisab/core/localization/locale_ar.dart';

import 'locale_en.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': LocaleEn.en,
        'ar': LocaleAr.ar,
      };
}
