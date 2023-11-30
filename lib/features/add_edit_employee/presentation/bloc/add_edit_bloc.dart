import 'package:bloc/bloc.dart';
import 'package:employee_management/core/data/entities/employee_data.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/del_by_id.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/insert_employee_record.dart';
import 'package:employee_management/features/add_edit_employee/domain/usecases/update_employees_list.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_event.dart';
import 'package:employee_management/features/add_edit_employee/presentation/bloc/add_edit_state.dart';
import 'package:flutter/material.dart';

/// Bloc for conversions widget
///
class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  final InsertEmployeeRecord _insertEmployeeRecord;
  final UpdateEmployeeRecord _updateEmployeeRecord;
  final DelEmployeeById _delEmployeeById;

  AddEditBloc(this._insertEmployeeRecord, this._updateEmployeeRecord,
      this._delEmployeeById)
      : super(AddEditPageInitial());

  bool _isInEditMode = false;
  get isInEditMode => _isInEditMode;

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  final roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  bool _canUndo = false;
  get canUndo => _canUndo;

  String uuid = "";
  DateTime? fromDateTime;
  DateTime? toDateTime;

  bool get isValidationSuccess {
    if (nameController.text.isEmpty ||
        roleController.text.isEmpty ||
        (fromDateTime == null)) {
      return false;
    }
    return true;
  }

  @override
  Stream<AddEditState> mapEventToState(AddEditEvent event) async* {
    if (event is AddEditPageOpened) {
      yield AddEditPageLoadInProgress();
      EmployeeData? employeeData = event.employeeData;
      if (employeeData != null) {
        fromDateTime = employeeData.fromDate;
        toDateTime = employeeData.toDate;
        uuid = employeeData.uuid;
        nameController.text = employeeData.name;
        roleController.text = employeeData.role;
        fromDateController.text = employeeData.fromDateString;
        toDateController.text = employeeData.toDateString;
        _isInEditMode = true;
      } else {
        nameController.text = "";
        roleController.text = "";
        fromDateController.text = "";
        toDateController.text = "";
        _isInEditMode = false;
      }
      yield AddEditPageLoadSuccess();
    } else if (event is DelEmployeeButtonTapped) {
      yield DelEmployeeInProgress();
      final result = await _delEmployeeById(uuid);
      yield* result.fold((Failure failure) async* {
        yield DelEmployeeFailure(failure);
      }, (r) async* {
        _canUndo = true;
        Future.delayed(
          const Duration(seconds: 3),
          () {
            if (_canUndo) {
              _canUndo = false;
              add(AddEditPageOpened(null));
            }
          },
        );
        yield DelEmployeeSuccess();
      });
    } else if (event is UndoDelButtonTapped) {
      _canUndo = false;
      yield UndoDelEmployeeInProgress();
      EmployeeData employeeData = EmployeeData(
          nameController.text, roleController.text, fromDateTime!, toDateTime);
      employeeData.uuid = uuid;
      final result = await _insertEmployeeRecord(employeeData);
      yield* result.fold((Failure failure) async* {
        yield UndoDelEmployeeFailure(failure);
      }, (r) async* {
        add(AddEditPageOpened(employeeData));
      });
    } else if (event is AddEmployeeButtonTapped) {
      _canUndo = false;
      yield AddEmployeeInProgress();
      EmployeeData employeeData = EmployeeData(
          nameController.text, roleController.text, fromDateTime!, toDateTime);
      if (isInEditMode) {
        await _delEmployeeById(uuid);
      }
      final result = await _insertEmployeeRecord(employeeData);
      yield* result.fold((Failure failure) async* {
        yield AddEmployeeFailure(failure);
      }, (r) async* {
        yield AddEmployeeSuccess();
        Future.delayed(
          const Duration(seconds: 3),
          () {
            add(AddEditPageOpened(employeeData));
          },
        );
      });
    }
  }
}
