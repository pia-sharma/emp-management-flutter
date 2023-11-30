/// Dependency Injection Container Configuration
///
/// This is where we manage construction of all dependencies for the live app.
///
/// These methods should not be used in testing. If you are testing code
/// which uses the DI container, you should just register any services you need
/// before constructing the class which uses the container as follows:
///
/// ```dart
/// var container = KiwiContainer();
///
/// container.registerInstance<FoobarSuper>(MockFoobarClass());
///
/// var thing = ThingWhichUsesContainer(container.resolve());
/// ```
///
/// As long as you haven't called [registerDependencyInjection] from inside
/// this module, this will then ensure that ThingWhichUsesContainer will
/// be handed a MockFoobarClass when it tries to look up a FoobarSuper.
import 'package:employee_management/core/data/datasources/local_datasource.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/data/repositories/employee_repository_impl.dart';
import 'package:employee_management/core/domain/repositories/employee_repository.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/del_by_id.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/insert_employee_record.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/update_employees_list.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_bloc.dart';
import 'package:employee_management/features/home/domain/usecases/del_employee_record.dart';
import 'package:employee_management/features/home/domain/usecases/get_employees_list.dart';
import 'package:employee_management/features/home/presentation/bloc/home_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kiwi/kiwi.dart';

Future<void> registerDependencyInjection() async {
  var container = KiwiContainer();
  container.clear();

  await _registerDataSources(container);
  _registerRepositories(container);
  _registerUseCases(container);
  _registerBloc(container);
}

/// Register all Data Sources with the production DI container
Future<void> _registerDataSources(KiwiContainer container) async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeDataAdapter());

  Box box = await Hive.openBox("employees");
  container.registerFactory<LocalDbDataSource>(
      (container) => LocalDbDataSourceImpl(box));
}

/// Register all Repositories with the production DI container
///
/// NOTE: Each repository should be registered against its Superclass to
/// facilitate Dependency Inversion, which is a core concept of the Clean
/// Architecture design pattern that we use throughout the app. Only one
/// repository must be registered for each Superclass/Contract.
void _registerRepositories(KiwiContainer container) {
  container.registerFactory<EmployeeRepository>(
      (c) => EmployeeRepositoryImpl(c.resolve()));
}

/// Register all Use Cases with the production DI container
///
/// Use Cases must be registered as their implementation, not as their
/// Superclass, as their contracts are used for abstraction, not dependency
/// inversion.
void _registerUseCases(KiwiContainer container) {
  container.registerFactory((c) => GetEmployeeList(c.resolve()));
  container.registerFactory((c) => InsertEmployeeRecord(c.resolve()));
  container.registerFactory((c) => UpdateEmployeeRecord(c.resolve()));
  container.registerFactory((c) => DelEmployeeRecord(c.resolve()));
  container.registerFactory((c) => DelEmployeeById(c.resolve()));
}

/// Register BLoCs with the production DI container
///
/// BLoCs must be registered as their concrete class, as their Superclasses are
/// used for abstraction, not dependency inversion.
void _registerBloc(KiwiContainer container) {
  container
      .registerFactory((c) => HomeBloc(c.resolve(), c.resolve(), c.resolve()));
  container.registerFactory(
      (c) => AddEditBloc(c.resolve(), c.resolve(), c.resolve()));
}
