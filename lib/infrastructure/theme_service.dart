import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/locale_storage_service.dart';
import 'package:inside_out/resources/palette_colors.dart';

enum ThemePreference { light, dark }

class ThemeService {
  final LocaleStorageService _localeStorageService;

  ThemeService(this._localeStorageService);

  static const String _keyTheme = 'themePreferenceInsideOut';

  late ThemePreference _theme;

  void init() {
    int? themeValue = _localeStorageService.getInt(_keyTheme);
    if (themeValue == null) {
      final Brightness brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _theme = brightness.name == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
      _saveCurrentTheme();
    } else {
      _theme = ThemePreference.values[themeValue];
    }
  }

  PaletteColors get paletteColors => _theme == ThemePreference.light ? PaletteColorsLight() : PaletteColorsDark();

  void setTheme(ThemePreference themePreference) {
    _theme = themePreference;
    _saveCurrentTheme();
  }

  void _saveCurrentTheme() => _localeStorageService.saveInt(_keyTheme, _theme.index);
}
