import 'package:dartz/dartz.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/domain/repositories/employee_repository.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:employee_management/core/usecases/usecase.dart';

class UpdateEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  UpdateEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.updateEmployeeRecord(params);
  }
}
