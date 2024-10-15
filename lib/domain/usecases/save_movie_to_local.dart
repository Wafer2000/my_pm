import 'package:dartz/dartz.dart';
import 'package:my_pm/core/usecase/usecase.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/domain/repositories/movie.dart';
import 'package:my_pm/service_locator.dart';

import '../../data/models/movie.dart';

class SaveMovieToLocalUseCase
    extends UseCase<Either<String, List<MovieEntity>>, MovieEntity> {
  @override
  Future<Either<String, List<MovieEntity>>> call({MovieEntity? params}) async {
    if (params == null) {
      return Left('Error: params is null, $params');
    }
    MovieModel movieModel = MovieModel(
      backdropPath: params.backdropPath ?? '',
      posterPath: params.posterPath ?? '',
      id: params.id ?? 0,
      title: params.title ?? 'No Title',
      overview: params.overview ?? 'No Overview',
      popularity: params.popularity ?? 0.0,
      releaseDate: params.releaseDate,
      voteAverage: params.voteAverage ?? 0.0,
    );

    return await sl<MovieRepository>().saveMovieDetailsToLocal(movieModel);
  }
}
