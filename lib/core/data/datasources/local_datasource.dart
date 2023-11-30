import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDbDataSource {
  Future<Iterable<dynamic>> getAllRecords();
  Future<bool> insertEmployeeRecord(EmployeeData employeeData);
  Future<bool> updateEmployeeRecord(EmployeeData employeeData);
  Future<bool> delEmployeeRecord(EmployeeData uuid);
  Future<bool> deleteRecordById(String uuid);
}

class LocalDbDataSourceImpl implements LocalDbDataSource {
  final Box box;
  LocalDbDataSourceImpl(this.box);

  @override
  Future<bool> delEmployeeRecord(EmployeeData employeeData) async {
    await employeeData.delete();
    return true;
  }

  @override
  Future<Iterable<dynamic>> getAllRecords() async {
    return box.values;
  }

  @override
  Future<bool> insertEmployeeRecord(EmployeeData employeeData) async {
    await box.add(employeeData);
    return true;
  }

  @override
  Future<bool> updateEmployeeRecord(EmployeeData employeeData) async {
    await employeeData.save();
    return true;
  }

  @override
  Future<bool> deleteRecordById(String uuid) async {
    EmployeeData employeeData = box.values
        .where((element) => element.uuid == uuid)
        .first as EmployeeData;
    employeeData.delete();
    return true;
  }
}
