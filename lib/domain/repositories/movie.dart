import 'package:dartz/dartz.dart';

import '../../data/models/movie.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<String, List<MovieEntity>>> getFavoriteMovies();
  Future<Either> getPopularMovies();
  Future<Either> getRecommendationMovies(int movieId);
  Future<Either> getSimilarMovies(int movieId);
  Future<Either<String, List<MovieEntity>>> getMoviesFromLocal();
  Future<Either<String, List<MovieEntity>>> saveMovieDetailsToLocal(
      MovieModel movie);
  Stream<Either<String, List<MovieEntity>>> getMoviesFromLocalStream();
  
}
