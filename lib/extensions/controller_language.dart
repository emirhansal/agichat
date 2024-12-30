import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/models/model_dropdown.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/utils/general_data.dart';
import 'package:flutter/services.dart';


class LanguageController {
  static AppLanguage currentAppLang = AppLanguage.en;

  static ModelDropdown tr =
      ModelDropdown(id: AppLanguage.tr.id, title: 'Türkçe', text: 'tr');
  static ModelDropdown en =
      ModelDropdown(id: AppLanguage.en.id, title: 'İngilizce', text: 'en');

  static late Locale currentLocale;
  static late Map<String, dynamic> selectedLocaleJson;

  static const String translationsPath = 'assets/translations';
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
  ];

  static Future<void> setLanguage(AppLanguage language) async {
    if (GeneralData.getInstance().getLanguage() != language) {
      currentAppLang = language;
      GeneralData.getInstance().setLanguage(language);
      await initialize();
    }
    R.refreshClass();

    log('current language: ${currentLocale.toLanguageTag()}',
        name: 'LOCALIZATION');
  }

  static Future<void> initialize() async {
    switch (GeneralData.getInstance().getLanguage()) {
      case AppLanguage.en:
        currentLocale = supportedLocales[0];
        currentAppLang = AppLanguage.en;
        await loadLang();
        break;
      default:
        var deviceLocale = Locale(Platform.localeName.substring(0, 2));
        int localeIndex = supportedLocales.indexWhere((element) => element.languageCode == deviceLocale.languageCode);
        if (localeIndex == -1) {
          currentLocale = supportedLocales[0];
          currentAppLang = AppLanguage.en;
          await loadLang();
          break;
        }
        currentLocale = supportedLocales[localeIndex];
        currentAppLang = AppLanguage.locale;
        await loadLang();
        break;
    }

    log('current language: ${currentLocale.toLanguageTag()}',
        name: 'LOCALIZATION');
  }

  static Future<void> loadLang() async {
    selectedLocaleJson = jsonDecode(await rootBundle
        .loadString('$translationsPath/${currentLocale.toLanguageTag()}.json'));
  }

  static List<ModelDropdown> getLanguagesForDropdown() {
    return [en, en];
  }

  static getLocale(String tag) {
    return supportedLocales.firstWhere((element) {
      return element.languageCode.substring(0, 2) == tag;
    });
  }
}
