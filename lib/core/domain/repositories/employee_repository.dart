import 'package:dartz/dartz.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/errors/failures.dart';

abstract class EmployeeRepository {
  /// This method deletes the record from db
  Future<Either<Failure, bool>> deleteEmployeeRecord(EmployeeData employee);

  Future<Either<Failure, bool>> deleteEmployeeById(String uuid);

  Future<Either<Failure, bool>> insertEmployeeRecord(EmployeeData employee);

  Future<Either<Failure, bool>> updateEmployeeRecord(EmployeeData employee);

  Future<Either<Failure, List<EmployeeData>>> getAllRecords();
}
