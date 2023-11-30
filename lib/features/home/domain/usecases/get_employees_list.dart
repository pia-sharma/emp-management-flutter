import 'package:dartz/dartz.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/domain/repositories/employee_repository.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:employee_management/core/usecases/usecase.dart';

class GetEmployeeList implements UseCase<List<EmployeeData>, NoParams> {
  final EmployeeRepository employeeRepository;
  GetEmployeeList(this.employeeRepository);

  @override
  Future<Either<Failure, List<EmployeeData>>> call(NoParams params) {
    return employeeRepository.getAllRecords();
  }
}
