import 'package:intl/intl.dart';

class DateRange {
  static DateTime now = DateTime.now();
  static DateTime today = DateTime(now.year, now.month, now.day);
  static DateTime thisWeek = today.subtract(const Duration(days: 6));
  static DateTime thisMonth = today.subtract(const Duration(days: 30));
  static DateTime thisYear = DateTime(now.year - 1, now.month, now.day);

  static String formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static List<String> formattedDateFilter({required String type}) {
    if (type == "this week") {
      return [formattedDate(thisWeek), formattedDate(today)];
    } else if (type == "this month") {
      return [formattedDate(thisMonth), formattedDate(today)];
    } else if (type == "this year") {
      return [formattedDate(thisYear), formattedDate(today)];
    } else {
      return [formattedDate(today), formattedDate(today)];
    }
  }
}
