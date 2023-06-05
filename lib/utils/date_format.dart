import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String getHHmm() {
    return DateFormat('HH:mm').format(this);
  }
}
