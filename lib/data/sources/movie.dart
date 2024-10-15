import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/constants/api_url.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/interceptors.dart';
import '../../domain/entities/movie.dart';
import '../../service_locator.dart';
import '../../core/errors/request_handler.dart';
import '../database/movie.dart';
import '../models/movie.dart';

abstract class MovieService {
  Future<Either<String, dynamic>> getFavoriteMovies();
  Future<Either<String, dynamic>> getPopularMovies();
  Future<Either<String, dynamic>> getRecommendationMovies(int movieId);
  Future<Either<String, dynamic>> getSimilarMovies(int movieId);
  Future<Either<String, List<MovieEntity>>> getMoviesFromLocal();
}

class MovieApiServiceImpl extends MovieService {
  late final MovieDatabase _movieDatabase;
  @override
  Future<Either<String, dynamic>> getFavoriteMovies() async {
    return handleRequest(() async {
      var response = await sl<DioClient>().get(ApiUrl.favoriteMoviesURL);
      return response.data;
    });
  }

  @override
  Future<Either<String, dynamic>> getPopularMovies() async {
    return handleRequest(() async {
      var response = await sl<DioClient>().get(ApiUrl.popularMovie);
      return response.data;
    });
  }

  @override
  Future<Either<String, dynamic>> getRecommendationMovies(int movieId) async {
    return handleRequest(() async {
      var response =
          await sl<DioClient>().get('${ApiUrl.movie}$movieId/recommendations');
      return response.data;
    });
  }

  @override
  Future<Either<String, dynamic>> getSimilarMovies(int movieId) async {
    return handleRequest(() async {
      var response =
          await sl<DioClient>().get('${ApiUrl.movie}$movieId/similar');
      return response.data;
    });
  }

  Future<Either<String, dynamic>> addFavoriteMovie(int? mediaId) async {
    final interceptor = AuthorizationInterceptor();
    return await interceptor.handleFavoriteMovie(mediaId, true);
  }

  Future<Either<String, dynamic>> quitFavoriteMovie(int? mediaId) async {
    final interceptor = AuthorizationInterceptor();
    return await interceptor.handleFavoriteMovie(mediaId, false);
  }

  Future<List<MovieEntity>> getAllMovies() async {
    final db = await _movieDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    if (maps.isEmpty) {
      return []; // Devuelve una lista vacía si no hay películas
    }
    return List.generate(maps.length, (i) {
      return MovieEntity.fromMap(maps[i]);
    });
  }

  @override
  Future<Either<String, List<MovieEntity>>> getMoviesFromLocal() async {
    // Implementación del método
    try {
      // Obtén la lista de películas
      final movies = await getAllMovies();
      return Right(movies); // Retorna el valor en caso de éxito
    } catch (error) {
      return Left("Error al obtener las películas: ${error.toString()}");
    }
  }

  Future<Either<String, bool>> isMovieFavorite(int movieId) async {
    final dio = sl<DioClient>().dio;

    // Obtener el access token de las variables de entorno
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      // Verificar que el access token exista antes de hacer la solicitud
      if (accessToken == null || accessToken.isEmpty) {
        return const Left('Access token is missing');
      }

      final response = await dio.get(
        ApiUrl.favoriteMoviesURL,
        options: Options(
          headers: {
            'Authorization':
                'Bearer $accessToken', // Añadir el token en los headers
          },
        ),
      );

      print(response.data);
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        final isFavorite = results.any((movie) => movie['id'] == movieId);
        return Right(isFavorite);
      } else {
        return Left(
            'Failed to check favorite status. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Left('Failed to check favorite status: ${e.message}');
    }
  }
}

class MovieLocalDataSource {
  final MovieDatabase _movieDatabase;

  MovieLocalDataSource(this._movieDatabase);

  Future<void> saveMovie(Map<String, dynamic> movieData) async {
    try {
      final movie = MovieModel.fromMap(movieData);
      await _movieDatabase.insertMovie(movie);
    } catch (e) {
      print('Error saving movie: $e');
    }
  }

  Future<List<MovieEntity>> getFavoriteMovies() async {
    print('Getting favorite movies...');
    try {
      final db = await _movieDatabase.database;
      final List<Map<String, dynamic>> maps =
          await db.query('movies', where: 'is_favorite = 1');
      print('Favorite movies obtained successfully!');
      return List.generate(maps.length, (i) {
        return MovieEntity.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error getting favorite movies: $e');
      return [];
    }
  }

  Future<List<MovieEntity>> getAllMovies() async {
    final db = await _movieDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    if (maps.isEmpty) {
      return []; // Devuelve una lista vacía si no hay películas
    }
    return List.generate(maps.length, (i) {
      return MovieEntity.fromMap(maps[i]);
    });
  }

  Stream<Either<String, List<MovieEntity>>> getMoviesFromLocalStream() async* {
    while (true) {
      yield await getMoviesFromLocal();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<Either<String, List<MovieEntity>>> getMoviesFromLocal() async {
    // Implementación del método
    try {
      // Obtén la lista de películas
      final movies = await getAllMovies();
      return Right(movies); // Retorna el valor en caso de éxito
    } catch (error) {
      return Left("Error al obtener las películas: ${error.toString()}");
    }
  }

  MovieEntity convertModelToEntity(MovieModel model) {
    // Convert MovieModel to MovieEntity
    return MovieEntity(
      id: model.id,
      title: model.title,
      backdropPath: model.backdropPath,
      posterPath: model.posterPath,
      overview: model.overview,
      popularity: model.popularity,
      releaseDate: model.releaseDate,
      voteAverage: model.voteAverage,
    );
  }

  Future<List<MovieEntity>> getLocalFavoriteMovies() async {
    try {
      // Get the favorite movies from the database as MovieModel
      List<MovieModel> movieModels = await _movieDatabase.getFavoriteMovies();

      // Convert List<MovieModel> to List<MovieEntity>
      List<MovieEntity> movieEntities =
          movieModels.map(convertModelToEntity).toList();

      return movieEntities;
    } catch (e) {
      print('Error getting local favorite movies: $e');
      return [];
    }
  }
}
