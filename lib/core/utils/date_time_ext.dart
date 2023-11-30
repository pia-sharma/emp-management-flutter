import 'package:employee_management/core/constants/constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension FormatDateTime on DateTime {
  String formatDate() {
    return DateFormat(Constants.dateFormat).format(this);
  }
}
