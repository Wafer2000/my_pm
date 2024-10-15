import 'package:flutter/material.dart';
import 'package:my_pm/common/widgets/category_text.dart';
import 'package:my_pm/presentation/home/widgets/popular_movies.dart';
import 'package:my_pm/presentation/home/widgets/favorite_movies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ReelStar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryText(title: 'Favorite ❤️'),
            FavoriteMovies(),
            SizedBox(
              height: 16,
            ),
            CategoryText(title: 'Popular Movie'),
            SizedBox(
              height: 16,
            ),
            PopularMovie(),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
