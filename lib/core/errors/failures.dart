import 'package:equatable/equatable.dart';

/// Core Failure abstract class
///
/// To be used in combination with the Dartz package, to implement the
/// functional programming Either paradigm. Must be extended into a core
/// collection of expected failure categories.
abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  const Failure([properties]);

  @override
  List<Object> get props => [properties];
}

/// Local cache failure
///
/// Returned when there is an error interacting with locally stored data.
///
/// This should be extended further by individual components to specify more
/// explicit failure types, but still allow us to confirm the core failure
/// type.
class CacheFailure extends Failure {
  final String message;
  const CacheFailure(this.message);

  @override
  String toString() {
    return message;
  }
}

/// System failure
///
/// Returned when there is an error interacting with the local system, but the
/// error is not related to the handling of physical data.
///
/// This should be extended further by individual components to specify more
/// explicit failure types, but still allow us to confirm the core failure
/// type.
class InternalFailure extends Failure {
  final String message;
  const InternalFailure(this.message);

  @override
  String toString() {
    return message;
  }
}

///Unknown failure
///
/// Thrown when any of request fails due to unknown reason
class UnknownFailure extends Failure {
  final String message;
  const UnknownFailure(this.message);

  @override
  String toString() {
    return message;
  }
}

///Unknown failure
///
/// Thrown when no records dound
class NoRecordsFoundFailure extends Failure {
  final String message;
  const NoRecordsFoundFailure(this.message);

  @override
  String toString() {
    return message;
  }
}

///Vaidation failure
///
/// Thrown when the user is invalid argument
/// or Invalid request or when mfa is already registered
///
class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message);
  @override
  String toString() {
    return message;
  }
}
