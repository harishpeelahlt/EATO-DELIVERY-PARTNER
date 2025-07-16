
// global_exception_handler.dart

import 'package:dio/dio.dart';

/// Base class for all app-specific exceptions
abstract class AppException implements Exception {
  final String message;
  final int? code;
  AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException ($code): $message';
}

// === Specific Exceptions ===
class UserNotFoundException extends AppException {
  UserNotFoundException(super.message, int super.code);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, int super.code);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message, int super.code);
}

class BadRequestException extends AppException {
  BadRequestException(super.message, int super.code);
}

class ConflictException extends AppException {
  ConflictException(super.message, int super.code);
}

class NotFoundException extends AppException {
  NotFoundException(super.message, int super.code);
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException(super.message, int super.code);
}

class NetworkException extends AppException {
  NetworkException([String message = "No internet connection"])
      : super(message, null);
}

class UnknownBackendException extends AppException {
  UnknownBackendException(super.message, [super.code]);
}

// === Error Mapper Function ===
AppException mapErrorCodeToException(int code, String message) {
  switch (code) {
    case 1000:
      return UserNotFoundException("User not found", code);
    case 1001:
      return ConflictException("User already exists", code);
    case 1002:
      return ConflictException("Email is already in use", code);
    case 1003:
    case 1200:
      return UnauthorizedException("Unauthorized access", code);
    case 1004:
      return ForbiddenException("Not a valid restaurant admin", code);
    case 1100:
    case 3001:
      return NotFoundException("Requested city/category not found", code);
    case 1101:
    case 1802:
    case 2000:
    case 3009:
    case 4003:
      return BadRequestException(message, code);
    case 1104:
    case 4102:
    case 3003:
    case 5003:
      return ConflictException(message, code);
    case 1203:
      return UnauthorizedException("API key expired", code);
    case 1204:
      return ForbiddenException("API key limit reached or access denied", code);
    case 1800:
      return NotFoundException("OTP not found", code);
    case 1801:
      return BadRequestException("OTP expired", code);
    case 1803:
      return BadRequestException("Invalid token or vote type", code);
    case 1805:
      return ForbiddenException("Unauthorized voting", code);
    case 1901:
    case 3005:
    case 4001:
    case 4002:
    case 4010:
      return NotFoundException(message, code);
    case 2001:
    case 5005:
      return InternalServerErrorException("Internal server error", code);
    case 2002:
    case 4008:
    case 4009:
      return ForbiddenException(message, code);
    case 2003:
      return BadRequestException("Method not allowed", code);
    case 2004:
      return BadRequestException("Null pointer exception", code);
    case 2005:
      return BadRequestException("JSON conversion or restaurant not found", code);
    case 2017:
      return ForbiddenException("Not enough coins for transaction", code);
    default:
      return UnknownBackendException("An unexpected error occurred: $message", code);
  }
}

// === Handle Dio Error and Map to AppException ===
AppException handleDioError(DioException e) {
  if (e.response != null) {
    final data = e.response?.data;
    final code = data?['code'] ?? -1;
    final message = data?['message'] ?? "Unexpected error occurred";
    return mapErrorCodeToException(code, message);
  } else {
    return NetworkException();
  }
}
