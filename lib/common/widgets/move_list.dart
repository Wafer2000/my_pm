import 'package:flutter/material.dart';
import 'package:my_pm/common/widgets/movie_card.dart';
import 'package:my_pm/domain/entities/movie.dart';

class MoveList extends StatelessWidget {
  const MoveList({
    super.key,
    required this.movies,
  });

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => MovieCard(movieEntity: movies[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: movies.length,
      ),
    );
  }
}
