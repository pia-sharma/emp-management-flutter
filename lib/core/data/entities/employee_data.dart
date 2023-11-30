import 'package:employee_management/core/constants/constants.dart';
import 'package:employee_management/core/utils/date_time_ext.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'employee_data.g.dart';

@HiveType(typeId: 0)
class EmployeeData extends HiveObject {
  @HiveField(0)
  String uuid = DateTime.now().microsecondsSinceEpoch.toString();

  @HiveField(1)
  String name;

  @HiveField(2)
  String role;

  @HiveField(3)
  DateTime fromDate;

  @HiveField(4)
  DateTime? toDate;

  EmployeeData(this.name, this.role, this.fromDate, this.toDate);

  get fromDateString {
    return fromDate.formatDate();
  }

  get toDateString {
    if (toDate != null) {
      return toDate!.formatDate();
    }
    return "";
  }

  get formattedTime {
    if (toDate != null) {
      return "$fromDateString - $toDateString";
    } else {
      return "$fromDateString";
    }
  }
}
