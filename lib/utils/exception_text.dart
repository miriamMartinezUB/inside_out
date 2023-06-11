import 'dart:core';

extension ExceptionText on String {
  String getMessage() {
    String s = this;
    s = s.replaceFirst('Exception: ', '');
    return (s);
  }
}
