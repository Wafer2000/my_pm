import 'package:flutter/material.dart';
import 'package:my_pm/presentation/watch/pages/movie_watch.dart';
import 'package:my_pm/presentation/watch/widgets/exports.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.widget,
  });

  final MovieWatchPage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackdropPath(backdropPath: widget.movieEntity.provideBackdropPath()),
        const SizedBox(height: 16),
        MyTitle(title: widget.movieEntity.title!),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReleaseDate(releaseDate: widget.movieEntity.releaseDate),
            Popularity(popularity: widget.movieEntity.popularity!),
            VoteAverage(voteAverage: widget.movieEntity.voteAverage!),
          ],
        ),
        const SizedBox(height: 16),
        Overview(overview: widget.movieEntity.overview!),
        const SizedBox(height: 16),
        RecommendationMovies(movieId: widget.movieEntity.id!),
        const SizedBox(height: 16),
        SimilarMovies(movieId: widget.movieEntity.id!),
      ],
    );
  }
}
