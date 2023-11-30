import 'package:dartz/dartz.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/domain/repositories/employee_repository.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:employee_management/core/usecases/usecase.dart';

/// This Usecase will be used to Get Profile image saved into Gallery

class InsertEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  InsertEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.insertEmployeeRecord(params);
  }
}
