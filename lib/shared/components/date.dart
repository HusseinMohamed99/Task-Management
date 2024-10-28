part of './../../core/helpers/export_manager/export_manager.dart';

class DateTimeUtils {
  static String formatTasksDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  static DateTime extractDateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}

extension ExtractDate on DateTime {
  DateTime extractDateOnly() {
    return DateTime(year, month, day);
  }
}
