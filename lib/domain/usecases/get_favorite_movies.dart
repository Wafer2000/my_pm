import 'package:dartz/dartz.dart';
import 'package:my_pm/core/usecase/usecase.dart';
import 'package:my_pm/domain/repositories/movie.dart';
import 'package:my_pm/service_locator.dart';
import 'package:my_pm/data/models/movie.dart';

class GetFavoriteMoviesUseCase
    extends UseCase<Either<String, List<MovieModel>>, dynamic> {
  @override
  Future<Either<String, List<MovieModel>>> call({params}) async {
    try {
      final eitherMovies = await sl<MovieRepository>().getFavoriteMovies();
      return eitherMovies.fold(
        (left) => Left(left.toString()),
        (right) => Right(right
            .map((movie) => MovieModel(
                  id: movie.id,
                  title: movie.title,
                  overview: movie.overview,
                  releaseDate: movie.releaseDate,
                  voteAverage: movie.voteAverage,
                  backdropPath: movie.backdropPath,
                  posterPath: movie.posterPath,
                  popularity: movie.popularity,
                ))
            .toList()),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
