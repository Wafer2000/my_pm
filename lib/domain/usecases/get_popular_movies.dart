import 'package:dartz/dartz.dart';
import 'package:my_pm/core/usecase/usecase.dart';
import 'package:my_pm/domain/repositories/movie.dart';
import 'package:my_pm/service_locator.dart';
import '../entities/movie.dart';
import 'save_movie_to_local.dart';

class GetPopularMoviesUseCase
    extends UseCase<Either<String, List<MovieEntity>>, dynamic> {
  @override
  Future<Either<String, List<MovieEntity>>> call({dynamic params}) async {
    try {
      // Intenta obtener películas de la API
      var response = await sl<MovieRepository>().getPopularMovies();

      // Si la respuesta es un error, intenta cargar desde local
      if (response.isLeft()) {
        final localResponse = await sl<MovieRepository>().getMoviesFromLocal();
        return localResponse.fold(
          (error) {
            // Si hay un error al cargar desde local, retorna ese error
            return Left('Error loading from local: $error');
          },
          (movies) {
            // Retorna las películas cargadas desde local
            return Right(movies);
          },
        );
      }

      // Si se obtuvieron películas desde la API, guárdalas en local
      return response.fold(
        (error) {
          // Manejo de error, puedes agregar lógica si lo necesitas
          return Left(error);
        },
        (movies) async {
          try {
            // Guardar cada película en almacenamiento local
            final futures = movies
                .map((movie) =>
                    (sl<SaveMovieToLocalUseCase>().call(params: movie)) as Future<dynamic>)
                .toList(); // Convertir a lista de Future<dynamic>
            await Future.wait(futures.cast<Future<dynamic>>()); // Casting explícito
            return Right(movies); // Retorna las películas obtenidas de la API
          } catch (e) {
            // En lugar de retornar un Left, rethrow la excepción
            rethrow;
          }
        },
      );
    } catch (e) {
      // En lugar de retornar un Left, rethrow la excepción
      rethrow;
    }
  }
}