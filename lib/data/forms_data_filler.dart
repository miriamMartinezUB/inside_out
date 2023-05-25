import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/resources/form_id.dart';

class FormsDataFiller {
  final Database database;

  FormsDataFiller(this.database);

  fillDatabaseWithData() {
    AppForm loginForm = AppForm(
      id: FormId.loginFormId,
      actionText: 'login',
      questions: [
        FreeTextQuestion(
          title: 'email',
          id: '21758d0a-2a01-4b38-95ba-074957e480df',
        ),
        FreeTextQuestion(
          title: 'password',
          id: 'e8cf4f93-ecb3-48eb-9169-c3788270bc96',
          isObscureText: true,
        ),
      ],
    );

    AppForm signUpForm = AppForm(
      id: FormId.signUpFormId,
      actionText: 'sign_up',
      questions: [
        FreeTextQuestion(
          title: 'name',
          id: '5dc6ff05-4006-442f-8f89-872098aa9065',
        ),
        FreeTextQuestion(
          title: 'email',
          id: '3bccdf94-9ffe-4717-91c0-fb4e28bf6a7a',
        ),
        FreeTextQuestion(
          title: 'password',
          id: 'c55ad583-a678-4f41-bdab-a6586e17c16a',
          isObscureText: true,
        ),
        FreeTextQuestion(
          title: 'repeat_password',
          id: 'f0fad578-730e-4120-8c20-8b776492f153',
          isObscureText: true,
        ),
      ],
    );

    ///Adding forms
    database.addForm(loginForm);
    database.addForm(signUpForm);
  }
}
