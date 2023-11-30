import 'package:employee_management/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomePageInitial extends HomeState {
  @override
  String toString() {
    return "HomePageInitial";
  }
}

class HomePageLoadInProgress extends HomeState {
  @override
  String toString() {
    return "HomePageLoadInProgress";
  }
}

class HomePageLoadSuccess extends HomeState {
  @override
  String toString() {
    return "HomePageLoadSuccess";
  }
}

class HomePageLoadFailure extends HomeState {
  final Failure failure;
  HomePageLoadFailure(this.failure);
  @override
  String toString() {
    return "HomePageLoadFailure";
  }
}

class DelEmployeeInProgress extends HomeState {
  @override
  String toString() {
    return "HomePageLoadInProgress";
  }
}

class DelEmployeeSuccess extends HomeState {
  @override
  String toString() {
    return "DelEmployeeSuccess";
  }
}

class DelEmployeeFailure extends HomeState {
  final Failure failure;
  DelEmployeeFailure(this.failure);
  @override
  String toString() {
    return "DelEmployeeFailure";
  }
}

class UndoDelInProgress extends HomeState {
  @override
  String toString() {
    return "UndoDelInProgress";
  }
}

class UndoDelSuccess extends HomeState {
  @override
  String toString() {
    return "UndoDelSuccess";
  }
}

class UndoDelFailure extends HomeState {
  final Failure failure;
  UndoDelFailure(this.failure);
  @override
  String toString() {
    return "UndoDelFailure";
  }
}
