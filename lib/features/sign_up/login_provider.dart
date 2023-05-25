import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/free_text_question.dart';
import 'package:inside_out/infrastructure/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService;

  LoginProvider(this.authService);

  Future<void> logIn(AppForm form) async {
    String email = (form.questions.firstWhere((element) => element.title == 'email') as FreeTextQuestion).value ?? '';
    String password =
        (form.questions.firstWhere((element) => element.title == 'password') as FreeTextQuestion).value ?? '';
    try {
      await authService.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      switch (e) {
        case AuthError.wrongPassword:
        case AuthError.invalidCredential:
          throw Exception(
              'Estas credenciales son invalidas, porfavor comprueve que los campos sean correctos -miss translation');
        case AuthError.invalidEmail:
          throw Exception('Este email es invalido, porfavor comprueve que este bien escrito -miss translation');
        case AuthError.error:
          throw Exception('Los campos obligatorios no pueden estar vacios -miss translation');
        default:
          throw Exception('Ha ocurrido un error, intentalo más adelante -miss translation');
      }
    }
  }
}
