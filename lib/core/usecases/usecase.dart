import 'package:dartz/dartz.dart';
import 'package:employee_management/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

/// A public interface to provide a base for a Usecase
///
/// Use Cases are core business logic classes. They are called by BLoC
/// implementations to keep full separation of Business Logic from the
/// Presentation layer.
///
/// T and Params are Generic placeholders for the success return type
/// and Parameters classes. Define these when you write the concrete
/// Use Case.
///
/// We also use the Dartz library to provide the functional programming
/// Either paradigm, where the Left type is returned on a failed run and
/// the Right generic type is returned on a successful run. This means
/// that a Use Case must have handled all possible exceptions, and
/// translated them into a reasonable Failure subtype for consumption
/// by the caller.
abstract class UseCase<T, Params> {
  /// Implement the async `call` method to implement a Use Case.
  Future<Either<Failure, T>> call(Params params);
}

/// No-op Use Case Parameter class to avoid using nullable types
class NoParams extends Equatable {
  @override
  List<Object> get props => [dynamic];
}
