import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/languages.dart';
import 'package:inside_out/resources/storage_keys.dart';

class LanguageService {
  late LocalizationDelegate _delegate;
  late StreamController<bool> languageChange;
  late LocaleStorageService _localeStorageService;

  Future<LocalizationDelegate> initDelegate(LocaleStorageService localeStorageService) async {
    _delegate = await LocalizationDelegate.create(
      fallbackLocale: LanguageCode.byDefault,
      supportedLocales: languageCodes,
      basePath: 'locale/i18n',
    );
    _localeStorageService = localeStorageService;
    String jsonUser = _localeStorageService.getString(StorageKeys.keyUser);
    if (jsonUser.isNotEmpty) {
      User user = User.fromJson(jsonDecode(jsonUser));
      if (_delegate.currentLocale.languageCode != user.locale) {
        await _delegate.changeLocale(Locale(user.locale, ''));
      }
    }
    languageChange = StreamController<bool>.broadcast();
    languageChange.add(false);
    return _delegate;
  }

  List<String> get languageCodes {
    return [
      LanguageCode.spanish,
      LanguageCode.catalan,
      LanguageCode.english,
    ];
  }

  List<Locale> get supportedLocales {
    return _delegate.supportedLocales;
  }

  LocalizationDelegate get delegate {
    return _delegate;
  }

  String get currentLanguageCode {
    return _delegate.currentLocale.languageCode;
  }

  Locale get currentLocale {
    return _delegate.currentLocale;
  }

  String get defaultLocaleCode => LanguageCode.byDefault;

  Future<void> changeCurrentLocale(String languageCode) async {
    if (_delegate.currentLocale.languageCode != languageCode) {
      await _delegate.changeLocale(Locale(languageCode, ''));
      languageChange.add(true);
    }
  }
}
