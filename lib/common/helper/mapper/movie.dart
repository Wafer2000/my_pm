import 'package:my_pm/data/models/movie.dart';
import 'package:my_pm/domain/entities/movie.dart';

class MovieMapper {

  static MovieEntity toEntity(MovieModel movie) {
    return MovieEntity(
      backdropPath: movie.backdropPath, 
      id: movie.id, 
      title: movie.title, 
      overview: movie.overview, 
      popularity: movie.popularity, 
      releaseDate: movie.releaseDate, 
      voteAverage: movie.voteAverage, 
      posterPath: movie.posterPath
    );
  }
}