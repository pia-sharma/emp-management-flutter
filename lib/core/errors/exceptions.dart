abstract class AuthException implements Exception {}

/// This is exception class for throwing cache related exception with message
///
class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() {
    return message;
  }
}

/// This exception is thrown when invalid argument passed
///
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  @override
  String toString() {
    return message;
  }
}
