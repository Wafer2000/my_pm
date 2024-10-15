import 'package:dartz/dartz.dart';
import 'package:my_pm/common/helper/mapper/movie.dart';
import 'package:my_pm/data/sources/movie.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/domain/repositories/movie.dart';
import 'package:my_pm/service_locator.dart';

import '../models/movie.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieLocalDataSource localDataSource;
  MovieRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<String, List<MovieEntity>>> getFavoriteMovies() async {
    var returnedData = await sl<MovieService>().getFavoriteMovies();

    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var movies = List.from(data['results'])
          .map((item) => MovieEntity.fromJson(item))
          .toList();
      return Right(movies);
    });
  }

  @override
  Future<Either<String, List<MovieEntity>>> getPopularMovies() async {
    var returnedData = await sl<MovieService>().getPopularMovies();

    return returnedData.fold((error) {
      return Left(error.toString());
    }, (data) {
      var movies = List.from(data['results'])
          .map((item) => MovieMapper.toEntity(MovieModel.fromJson(item)))
          .toList();
      return Right(movies);
    });
  }

  @override
  Future<Either> getRecommendationMovies(int movieId) async {
    var returnedData =
        await sl<MovieService>().getRecommendationMovies(movieId);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var movies = List.from(data['results'])
          .map((item) => MovieMapper.toEntity(MovieModel.fromJson(item)))
          .toList();
      return Right(movies);
    });
  }

  @override
  Future<Either> getSimilarMovies(int movieId) async {
    var returnedData = await sl<MovieService>().getSimilarMovies(movieId);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var movies = List.from(data['results'])
          .map((item) => MovieMapper.toEntity(MovieModel.fromJson(item)))
          .toList();
      return Right(movies);
    });
  }

  @override
  Future<Either<String, List<MovieEntity>>> saveMovieDetailsToLocal(
      MovieModel movie) async {
    try {
      await localDataSource.saveMovie(movie.toMap());
      return Right([MovieMapper.toEntity(movie)]);
    } catch (error) {
      print('Error al guardar la película: $error');
      return Left('$error');
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> getMoviesFromLocal() async {
    try {
      final movies = await localDataSource.getAllMovies();
      print('Peliculas: ${movies.map((movie) => movie.title).toList()}');
      if (movies.isEmpty) {
        return const Left('Error getting movies from local: No movies found');
      }
      return Right(movies);
    } catch (e) {
      return Left('Error getting movies from local: ${e.toString()}');
    }
  }

  @override
  Stream<Either<String, List<MovieEntity>>> getMoviesFromLocalStream() async* {
    yield* sl<MovieLocalDataSource>().getMoviesFromLocalStream();
  }
}
