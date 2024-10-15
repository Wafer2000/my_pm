// data/tv/error/request_handler.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'error_mapper.dart';

Future<Either<String, T>> handleRequest<T>(Future<T> Function() request) async {
  try {
    final result = await request();
    return Right(result);
  } on DioException catch (e) {
    String errorMessage = mapErrorToMessage(e);
    return Left(errorMessage);
  }
}
