import 'package:flutter/widgets.dart';
import 'package:inside_out/data/form_data_filler.dart';
import 'package:inside_out/domain/form.dart';

class Database {
  final Map<String, AppForm> _forms = {};

  Database() {
    FormDataFiller(this).fillDatabaseWithData();
  }

  void addForm(AppForm appForm) {
    _forms[appForm.id] = appForm;
  }

  AppForm getFormById(String formId) {
    if (_forms.containsKey(formId)) {
      return _forms[formId]!;
    }
    throw FlutterError('Not form for id: $formId');
  }
}
