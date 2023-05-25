import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/free_text_question.dart';
import 'package:inside_out/infrastructure/auth_service.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final AuthService authService;

  ForgotPasswordProvider(this.authService);

  Future<void> recoverPassword(AppForm form) async {
    String email = (form.questions.firstWhere((element) => element.title == 'email') as FreeTextQuestion).value ?? '';
    await authService.recoverPassword(email.trim());
  }
}
