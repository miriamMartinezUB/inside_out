import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/free_text_question.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService authService;
  final ThemeService themeService;
  final LanguageService languageService;

  SignUpProvider({
    required this.authService,
    required this.themeService,
    required this.languageService,
  });

  Future<void> signUp(AppForm form) async {
    String name = (form.questions.firstWhere((element) => element.title == 'name') as FreeTextQuestion).value ?? '';
    String email = (form.questions.firstWhere((element) => element.title == 'email') as FreeTextQuestion).value ?? '';
    String password =
        (form.questions.firstWhere((element) => element.title == 'password') as FreeTextQuestion).value ?? '';
    String repeatedPassword =
        (form.questions.firstWhere((element) => element.title == 'repeat_password') as FreeTextQuestion).value ?? '';
    try {
      await authService.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
        repeatedPassword: repeatedPassword,
        name: name.trim(),
        locale: languageService.currentLanguageCode,
        themePreference: themeService.themePreference.name,
      );
    } catch (e) {
      switch (e) {
        case AuthError.emailAlreadyInUse:
          throw Exception('exception_email_already_in_use');
        case AuthError.passwordNotEquals:
          throw Exception('exception_password_not_equals');
        case AuthError.invalidEmail:
          throw Exception('exception_invalid_email');
        case AuthError.weakPassword:
          throw Exception('exception_weak_password');
        case AuthError.emptyFields:
          throw Exception('exception_empty_fields');
      }
    }
  }
}
