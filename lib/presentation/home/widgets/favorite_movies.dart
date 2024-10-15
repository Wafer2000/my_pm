import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pm/data/sources/movie.dart';
import 'package:my_pm/presentation/home/bloc/favorite_cubit.dart';
import 'package:my_pm/common/widgets/movie_carousel.dart';
import '../../../core/network/check_internet_connection.dart';
import '../../../data/database/movie.dart';
import '../../../domain/entities/movie.dart';
import '../bloc/favorite_state.dart';
import '../../../common/widgets/movie_error.dart';
import '../../../common/widgets/movie_loading.dart';

class FavoriteMovies extends StatefulWidget {
  const FavoriteMovies({super.key});

  @override
  State<FavoriteMovies> createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavoriteMovies(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return StreamBuilder<ConnectionStatus>(
            stream: CheckInternetConnection().internetStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const MovieError(message: 'Error getting movies');
              }
              if (!snapshot.hasData) return const MovieLoading();

              if (snapshot.data == ConnectionStatus.online) {
                if (state is FavoriteMoviesLoading) {
                  return const MovieLoading();
                }

                if (state is FavoriteMoviesSucess) {
                  if (state.movies.isEmpty) {
                    return const Center(
                      child: Text(
                          'You have not added any movies to your favorites.'),
                    );
                  } else {
                    return MovieCarousel(movies: state.movies);
                  }
                }

                if (state is FailureLoadFavoriteMovies) {
                  print(state.errorMessage);
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text('Error message: ${state.errorMessage}')),
                  );
                }
              } else {
                return FutureBuilder<List<MovieEntity>>(
                  future: MovieLocalDataSource(MovieDatabase())
                      .getLocalFavoriteMovies(),
                  builder: (context, localSnapshot) {
                    if (localSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const MovieLoading();
                    }

                    if (localSnapshot.hasError) {
                      return const MovieError(
                          message: 'Error loading local movies');
                    }

                    if (localSnapshot.hasData &&
                        localSnapshot.data!.isNotEmpty) {
                      return MovieCarousel(movies: localSnapshot.data!);
                    } else {
                      return const Center(
                        child: Text('No local favorite movies found.'),
                      );
                    }
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
