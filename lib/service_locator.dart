import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'data/database/movie.dart';
import 'data/repositories/movie.dart';
import 'data/sources/movie.dart';
import 'domain/repositories/movie.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_recommendation_movies.dart';
import 'domain/usecases/get_similar_movies.dart';
import 'domain/usecases/get_favorite_movies.dart';
import 'domain/usecases/save_movie_to_local.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Database
  sl.registerSingleton<MovieDatabase>(MovieDatabase());

  // Services
  sl.registerSingleton<MovieService>(MovieApiServiceImpl());
  sl.registerLazySingleton<MovieApiServiceImpl>(() => MovieApiServiceImpl());

  // Repostories
  sl.registerSingleton<MovieLocalDataSource>(
      MovieLocalDataSource(sl<MovieDatabase>()));
  sl.registerSingleton<MovieRepository>(
      MovieRepositoryImpl(localDataSource: sl<MovieLocalDataSource>()));

  // Usecases
  sl.registerFactory<SaveMovieToLocalUseCase>(() => SaveMovieToLocalUseCase());
  sl.registerSingleton<GetFavoriteMoviesUseCase>(GetFavoriteMoviesUseCase());
  sl.registerSingleton<GetPopularMoviesUseCase>(GetPopularMoviesUseCase());
  sl.registerSingleton<GetRecommendationMoviesUseCase>(
      GetRecommendationMoviesUseCase());
  sl.registerSingleton<GetSimilarMoviesUseCase>(GetSimilarMoviesUseCase());
}
