import 'package:my_pm/core/configs/assets/app_images.dart';

import '../../data/models/movie.dart';

class MovieEntity {
  MovieEntity({
    required this.backdropPath,
    required this.posterPath,
    required this.id,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
  });

  final String? backdropPath;
  final String? posterPath;
  final int? id;
  final String? title;
  final String? overview;
  final double? popularity;
  final String releaseDate;
  final double? voteAverage;

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity']?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
    );
  }

  static MovieEntity fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      backdropPath: map['backdropPath'] ?? '',
      posterPath: map['posterPath'] ?? '',
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: (map['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate: map['releaseDate'] ?? '',
      voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  MovieModel toModel() {
    return MovieModel(
      id: id,
      title: title,
      overview: overview,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      backdropPath: backdropPath,
      posterPath: posterPath,
      popularity: popularity,
    );
  }

  String provideBackdropPath() {
    return backdropPath != null
        ? AppImages.movieImageBasePath + backdropPath!
        : AppImages.defaultImageNetwork;
  }

  String providePosterPath() {
    return posterPath != null
        ? AppImages.movieImageBasePath + posterPath!
        : AppImages.defaultImageNetwork;
  }
}
