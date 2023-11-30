import 'package:bloc/bloc.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:employee_management/core/usecases/usecase.dart';
import 'package:employee_management/core/utils/date_time_ext.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/insert_employee_record.dart';
import 'package:employee_management/features/home/domain/usecases/del_employee_record.dart';
import 'package:employee_management/features/home/domain/usecases/get_employees_list.dart';
import 'package:employee_management/features/home/presentation/bloc/home_event.dart';
import 'package:employee_management/features/home/presentation/bloc/home_state.dart';

/// Bloc for conversions widget
///
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeeList _getEmployeeList;
  final InsertEmployeeRecord _insertEmployeeRecord;
  final DelEmployeeRecord _delEmployeeRecord;

  HomeBloc(this._getEmployeeList, this._insertEmployeeRecord,
      this._delEmployeeRecord)
      : super(HomePageInitial());

  List<EmployeeData> currentEmployees = [];
  List<EmployeeData> previousEmployees = [];

  bool _canUndo = false;
  EmployeeData? _employeeData;

  get canUndo => _canUndo;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomePageOpened) {
      yield HomePageLoadInProgress();

      final result = await _getEmployeeList(NoParams());
      yield* result.fold((Failure failure) async* {
        yield HomePageLoadFailure(failure);
      }, (r) async* {
        currentEmployees.clear();
        previousEmployees.clear();

        for (var element in r) {
          if (element.toDate == null) {
            currentEmployees.add(element);
          } else if (element.toDate != null) {
            if (element.toDate!.isAfter(DateTime.now())) {
              currentEmployees.add(element);
            } else {
              previousEmployees.add(element);
            }
          }
        }
        yield HomePageLoadSuccess();
      });
    } else if (event is DelEmployeeTapped) {
      yield DelEmployeeInProgress();
      _employeeData = event.employeeData;
      final result = await _delEmployeeRecord(_employeeData!);
      yield* result.fold(
        (Failure failure) async* {
          yield DelEmployeeFailure(failure);
        },
        (r) async* {
          Future.delayed(
            const Duration(seconds: 3),
            () async {
              if (_canUndo) {
                _canUndo = false;
                _employeeData = null;
                add(HomePageOpened());
              }
            },
          );
          _canUndo = true;
          add(HomePageOpened());
        },
      );
    } else if (event is UndoDelEmployeeTapped) {
      if (_canUndo && _employeeData != null) {
        yield UndoDelInProgress();
        final result = await _insertEmployeeRecord(_employeeData!);
        yield* result.fold(
          (Failure failure) async* {
            yield UndoDelFailure(failure);
          },
          (r) async* {
            _canUndo = false;
            _employeeData = null;
            add(HomePageOpened());
          },
        );
      }
    }
  }
}
