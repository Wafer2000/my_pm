import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pm/presentation/home/pages/home.dart';
import 'package:my_pm/presentation/splash/pages/splash.dart';
import 'package:my_pm/presentation/watch/pages/movie_watch.dart';

import '../../../domain/entities/movie.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          // Verificar si extra no es null y es un MovieEntity
          if (state.extra != null && state.extra is MovieEntity) {
            final movieEntity = state.extra as MovieEntity;
            return MovieWatchPage(movieEntity: movieEntity);
          } else {
            // Manejar el caso de que no se pase un MovieEntity
            return const Scaffold(
              body: Center(
                child: Text('Error: No se encontró la película.'),
              ),
            );
          }
        },
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
    ],
  );
}
