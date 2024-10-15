import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../service_locator.dart';
import '../constants/api_url.dart';
import 'dio_client.dart';

class AuthorizationInterceptor extends Interceptor {
  final accessToken = dotenv.env['ACCESS_TOKEN'];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }

    options.queryParameters['language'] = 'en-US';

    handler.next(options);
  }

  Future<Either<String, dynamic>> handleFavoriteMovie(
      int? mediaId, bool favorite) async {
    return await _handleFavoriteMovie(mediaId, favorite);
  }

  Future<Either<String, dynamic>> _handleFavoriteMovie(
      int? mediaId, bool favorite) async {
    const url = ApiUrl.postFavoriteMoviesURL;
    final dioClient = sl<DioClient>();
    final data = {
      'media_type': 'movie',
      'media_id': mediaId,
      'favorite': favorite,
    };

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dioClient.post(url,
          data: data, options: Options(headers: headers));
      if (response.statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(
            'Error al ${favorite ? 'agregar' : 'eliminar'} de favoritos: ${response.statusCode}');
      }
    } catch (e) {
      return Left(
          'Error al ${favorite ? 'agregar' : 'eliminar'} de favoritos: ${e.toString()}');
    }
  }
}
