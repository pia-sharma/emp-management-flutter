import 'package:employee_management/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

class AddEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEditPageInitial extends AddEditState {
  @override
  String toString() {
    return "AddEditPageInitial";
  }
}

class AddEditPageLoadInProgress extends AddEditState {
  @override
  String toString() {
    return "AddEditPageLoadInProgress";
  }
}

class AddEditPageLoadSuccess extends AddEditState {
  @override
  String toString() {
    return "AddEditPageLoadSuccess";
  }
}

class DelEmployeeInProgress extends AddEditState {
  @override
  String toString() {
    return "DelEmployeeInProgress";
  }
}

class DelEmployeeSuccess extends AddEditState {
  @override
  String toString() {
    return "DelEmployeeSuccess";
  }
}

class DelEmployeeFailure extends AddEditState {
  final Failure failure;
  DelEmployeeFailure(this.failure);
  @override
  String toString() {
    return "DelEmployeeFailure";
  }
}

class UndoDelEmployeeInProgress extends AddEditState {
  @override
  String toString() {
    return "UndoDelEmployeeInProgress";
  }
}

class UndoDelEmployeeSuccess extends AddEditState {
  @override
  String toString() {
    return "UndoDelEmployeeSuccess";
  }
}

class UndoDelEmployeeFailure extends AddEditState {
  final Failure failure;
  UndoDelEmployeeFailure(this.failure);
  @override
  String toString() {
    return "UndoDelEmployeeFailure";
  }
}

class AddEmployeeInProgress extends AddEditState {
  @override
  String toString() {
    return "AddEmployeeInProgress";
  }
}

class AddEmployeeSuccess extends AddEditState {
  @override
  String toString() {
    return "AddEmployeeSuccess";
  }
}

class AddEmployeeFailure extends AddEditState {
  final Failure failure;
  AddEmployeeFailure(this.failure);
  @override
  String toString() {
    return "AddEmployeeFailure";
  }
}
