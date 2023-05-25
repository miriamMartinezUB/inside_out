import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/free_text_question.dart';
import 'package:inside_out/infrastructure/auth_service.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService authService;

  SignUpProvider(this.authService);

  Future<void> signUp(AppForm form) async {
    String name = (form.questions.firstWhere((element) => element.title == 'name') as FreeTextQuestion).value ?? '';
    String email = (form.questions.firstWhere((element) => element.title == 'email') as FreeTextQuestion).value ?? '';
    String password =
        (form.questions.firstWhere((element) => element.title == 'password') as FreeTextQuestion).value ?? '';
    String repeatedPassword =
        (form.questions.firstWhere((element) => element.title == 'repeat_password') as FreeTextQuestion).value ?? '';
    try {
      await authService.createUserWithEmailAndPassword(
          email: email, password: password, repeatedPassword: repeatedPassword, name: name);
    } on AuthError catch (e) {
      print(e.toString());
      switch (e) {
        case AuthError.emailAlreadyInUse:
          throw Exception('Este email ya se encuentra en uso -miss translation');
        case AuthError.passwordNotEquals:
          throw Exception('Las constraseñas no coinciden -miss translation');
        case AuthError.invalidEmail:
          throw Exception('Este email es invalido, porfavor comprueve que este bien escrito -miss translation');
        case AuthError.weakPassword:
          throw Exception(
              'La seguridd de la contraseña es muy debil pruebe con una que contenga minimo una mayuscula, una minuscula, un numero y un caracter -miss translation');
        case AuthError.error:
          throw Exception('Los campos obligatorios no pueden estar vacios -miss translation');
        default:
          throw Exception('Ha ocurrido un error, intentalo más adelante -miss translation');
      }
    }
  }
}
