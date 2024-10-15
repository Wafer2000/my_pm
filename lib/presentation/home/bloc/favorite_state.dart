import 'package:my_pm/domain/entities/movie.dart';

abstract class FavoriteState {}

class FavoriteMoviesLoading extends FavoriteState {}

class FavoriteMoviesSucess extends FavoriteState {
  final List<MovieEntity> movies;
  FavoriteMoviesSucess({required this.movies});
}

class FailureLoadFavoriteMovies extends FavoriteState {
  final String errorMessage;
  FailureLoadFavoriteMovies({required this.errorMessage});
}