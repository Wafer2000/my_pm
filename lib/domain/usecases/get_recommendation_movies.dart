import 'package:dartz/dartz.dart';
import 'package:my_pm/core/usecase/usecase.dart';
import 'package:my_pm/domain/repositories/movie.dart';
import 'package:my_pm/service_locator.dart';

class GetRecommendationMoviesUseCase extends UseCase<Either,int> {
  
  @override
  Future<Either> call({int ? params}) async {
    return await sl<MovieRepository>().getRecommendationMovies(params!);
  }
  
}