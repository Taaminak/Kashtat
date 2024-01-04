import 'dart:async';
import 'package:dartz/dartz.dart';

// create a future response type using either
typedef ServerResponse<Object> = FutureOr<Either<Failure, Success<Object>>>;

class Success<model> {
  final String message;
  final Object data;

  const Success({
    required this.message,
    required this.data,
  });
}

class Failure {
  final Object failure;

  Failure({required this.failure});
}
