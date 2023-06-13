import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/free_text_question.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService;
  final ThemeService themeService;
  final LanguageService languageService;

  LoginProvider({
    required this.authService,
    required this.themeService,
    required this.languageService,
  });
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> logIn(AppForm form) async {
    String email = (form.questions.firstWhere((element) => element.title == 'email') as FreeTextQuestion).value ?? '';
    String password =
        (form.questions.firstWhere((element) => element.title == 'password') as FreeTextQuestion).value ?? '';
    try {
      await authService.signInWithEmailAndPassword(email: email.trim(), password: password);
      _isLoading = true;
      notifyListeners();
      User? user = authService.user;
      if (user != null) {
        await updateLanguage(user);
        updateTheme(user);
      }
    } catch (e) {
      switch (e) {
        case AuthError.wrongPassword:
        case AuthError.invalidCredential:
        case AuthError.userNotFound:
          throw Exception('exception_invalid_credential');
        case AuthError.invalidEmail:
          throw Exception('exception_invalid_email');
        case AuthError.emptyFields:
          throw Exception('exception_empty_fields');
      }
    }
  }

  Future<void> updateLanguage(User user) async {
    if (languageService.currentLanguageCode != user.locale) {
      await languageService.changeCurrentLocale(user.locale);
    }
  }

  void updateTheme(User user) {
    if (themeService.themePreference.name != user.themePreference) {
      themeService
          .setTheme(user.themePreference == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark);
    }
  }
}
