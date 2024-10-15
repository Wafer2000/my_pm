import 'package:flutter/material.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/common/widgets/move_list.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({
    super.key,
    required this.movies,
    required this.isOnline,
  });

  final List<MovieEntity> movies;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(child: Text('No movies available'));
    }
    return MoveList(movies: movies);
  }
}
