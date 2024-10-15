import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pm/common/bloc/generic_data_cubit.dart';
import 'package:my_pm/common/bloc/generic_data_state.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/domain/usecases/get_recommendation_movies.dart';
import 'package:my_pm/service_locator.dart';
import '../../../common/widgets/movie_card.dart';

class RecommendationMovies extends StatelessWidget {
  final int movieId;
  const RecommendationMovies({required this.movieId,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenericDataCubit()..getData<List<MovieEntity>>(sl<GetRecommendationMoviesUseCase>(),params: movieId),
      child: BlocBuilder<GenericDataCubit,GenericDataState>(
        builder: (context, state) {
          if (state is DataLoading){
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          
          if (state is DataSucess ){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movieEntity: state.data[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(width: 10,),
                    itemCount: state.data.length
                  ),
                ),
              ],
            );
          }

          if (state is FailureLoadData) {
            return Text(state.errorMessage);
          }

          return Container();
        },
      )
    );
  }
}