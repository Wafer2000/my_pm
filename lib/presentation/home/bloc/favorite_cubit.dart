import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pm/domain/usecases/get_favorite_movies.dart';
import 'package:my_pm/presentation/home/bloc/favorite_state.dart';
import 'package:my_pm/service_locator.dart';
import 'package:my_pm/data/database/movie.dart';

import '../../../data/models/movie.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteMoviesLoading());

  void getFavoriteMovies() async {
    try {
      var returnedData = await sl<GetFavoriteMoviesUseCase>().call();
      returnedData.fold(
        (error) {
          emit(
            FailureLoadFavoriteMovies(errorMessage: error),
          );
        },
        (data) async {
          // await sl<MovieDatabase>().clearFavoriteMovies();

          List<MovieModel> movieModels = [];
          for (var movie in data) {
            var movieModel = MovieModel(
              id: movie.id,
              title: movie.title,
              overview: movie.overview,
              releaseDate: movie.releaseDate,
              voteAverage: movie.voteAverage,
              backdropPath: movie.backdropPath,
              posterPath: movie.posterPath,
              popularity: movie.popularity,
            );
            movieModels.add(movieModel);
            await sl<MovieDatabase>().insertFavoriteMovie(movieModel);
          }

          // Emitir el éxito con los nuevos datos
          emit(
            FavoriteMoviesSucess(
              movies: movieModels
                  .map((movieModel) => movieModel.toEntity())
                  .toList(),
            ),
          );
        },
      );
    } catch (e) {
      print('Error en getFavoriteMovies: $e');
      emit(FailureLoadFavoriteMovies(errorMessage: e.toString()));
    }
  }
}
