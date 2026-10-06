import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Base type for every error that crosses the data → presentation boundary.
///
/// Repositories translate infrastructure errors (Firebase, platform) into
/// one of these so the UI can render a friendly, consistent message.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException([
    super.message = 'You appear to be offline. Changes will sync when the connection is back.',
  ]);
}

final class NotFoundException extends AppException {
  const NotFoundException([super.message = 'The requested record was not found.']);
}

final class PermissionDeniedException extends AppException {
  const PermissionDeniedException([
    super.message = 'You do not have permission to perform this action.',
  ]);
}

final class ValidationException extends AppException {
  const ValidationException(super.message);
}

final class ConflictException extends AppException {
  const ConflictException(super.message);
}

final class AuthenticationException extends AppException {
  const AuthenticationException([super.message = 'Invalid credentials.']);
}

final class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Something went wrong. Please try again.',
    Object? cause,
    StackTrace? stackTrace,
  ]) : super(cause: cause, stackTrace: stackTrace);
}

/// Maps any thrown object into an [AppException].
AppException mapToAppException(Object error, [StackTrace? stackTrace]) {
  if (error is AppException) return error;
  if (error is FirebaseException) {
    switch (error.code) {
      case 'unavailable':
      case 'deadline-exceeded':
        return const NetworkException();
      case 'permission-denied':
      case 'unauthenticated':
        return const PermissionDeniedException();
      case 'not-found':
        return const NotFoundException();
      case 'already-exists':
        return const ConflictException('This record already exists.');
      case 'failed-precondition':
        return UnknownException(
          error.message ?? 'The database rejected the request (failed precondition).',
          error,
          stackTrace,
        );
      default:
        return UnknownException(
          error.message ?? 'A database error occurred (${error.code}).',
          error,
          stackTrace,
        );
    }
  }
  if (error is TimeoutException) return const NetworkException();
  return UnknownException('Something went wrong. Please try again.', error, stackTrace);
}

/// Human readable message for any error object.
String errorMessageOf(Object? error) {
  if (error == null) return 'Unknown error';
  return mapToAppException(error).message;
}
