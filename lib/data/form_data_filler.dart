import 'package:inside_out/data/database.dart';
import 'package:inside_out/features/sign_up/forms.dart';

class FormDataFiller {
  final Database database;

  FormDataFiller(this.database);

  fillDatabaseWithData() {
    ///Adding forms
    database.addForm(loginForm);
    database.addForm(signUpForm);
  }
}
