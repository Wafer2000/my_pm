// data/tv/error/error_mapper.dart
import 'package:dio/dio.dart';

String mapErrorToMessage(DioException e) {
  if (e.response != null && e.response!.data != null) {
    int statusCode = e.response!.statusCode ?? 500;
    String defaultMessage = 'An error occurred';

    switch (statusCode) {
      case 200:
        return 'Success.';
      case 401:
        return 'Authentication failed: You do not have permissions to access the service.';
      case 404:
        return 'The resource you requested could not be found.';
      case 405:
        return 'Invalid format: This service doesn\'t exist in that format.';
      case 422:
        return 'Invalid parameters: Your request parameters are incorrect.';
      case 429:
        return 'Your request count is over the allowed limit.';
      case 500:
        return 'Internal error: Something went wrong.';
      case 503:
        return 'Service offline: This service is temporarily offline, try again later.';
      default:
        return defaultMessage;
    }
  }
  return 'An error occurred: ${e.message}';
}
