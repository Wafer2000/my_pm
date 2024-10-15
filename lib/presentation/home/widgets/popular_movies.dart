import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_pm/common/bloc/generic_data_cubit.dart';
import 'package:my_pm/common/bloc/generic_data_state.dart';
import 'package:my_pm/core/network/check_internet_connection.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/common/widgets/movie_error.dart';
import 'package:my_pm/common/widgets/movie_loading.dart';
import 'package:my_pm/common/widgets/movie_content.dart';
import 'package:my_pm/service_locator.dart';

import '../../../domain/repositories/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

class PopularMovie extends StatelessWidget {
  const PopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenericDataCubit()
        ..getData<List<MovieEntity>>(sl<GetPopularMoviesUseCase>()),
      child: BlocBuilder<GenericDataCubit, GenericDataState>(
        builder: (context, state) {
          return StreamBuilder<ConnectionStatus>(
            stream: CheckInternetConnection().internetStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const MovieError(message: 'Error al obtener conexión');
              }

              if (!snapshot.hasData) return const MovieLoading();

              if (snapshot.data == ConnectionStatus.online) {
                if (state is DataLoading) return const MovieLoading();
                if (state is DataSucess<List<MovieEntity>>) {
                  return MovieContent(movies: state.data, isOnline: true);
                }
                if (state is FailureLoadData) {
                  return MovieError(message: state.errorMessage);
                }
              } else {
                return FutureBuilder<Either<String, List<MovieEntity>>>(
                  future: sl<MovieRepository>().getMoviesFromLocal(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return MovieError(message: snapshot.error.toString());
                    }

                    if (!snapshot.hasData) return const MovieLoading();

                    // Aquí se asegura que snapshot.data no sea nulo
                    return snapshot.data!.fold(
                      (error) {
                        return MovieError(message: error);
                      },
                      (movies) => MovieContent(movies: movies, isOnline: false),
                    );
                  },
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
