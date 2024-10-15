import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pm/domain/entities/movie.dart';
import 'package:my_pm/presentation/watch/widgets/movie_details.dart';
import '../../../common/widgets/movie_error.dart';
import '../../../common/widgets/movie_loading.dart';
import '../../../core/network/check_internet_connection.dart';
import '../../../data/sources/movie.dart';
import '../../../service_locator.dart';

class MovieWatchPage extends StatefulWidget {
  final MovieEntity movieEntity;

  const MovieWatchPage({required this.movieEntity, super.key});

  @override
  State<MovieWatchPage> createState() => _MovieWatchPageState();
}

class _MovieWatchPageState extends State<MovieWatchPage> {
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    setState(() {
      _isLoading = true;
    });
    final isFavoriteResult =
        await sl<MovieApiServiceImpl>().isMovieFavorite(widget.movieEntity.id!);

    isFavoriteResult.fold(
      (error) {
        print('Error al verificar el estado de favorito: $error');
        setState(() {
          _isLoading = false; // Fin de la carga incluso si hubo error
        });
      },
      (isFavorite) {
        setState(() {
          _isFavorite = isFavorite;
          _isLoading = false; // Fin de la carga después de la verificación
        });
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          '${widget.movieEntity.title}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/home');
        },
      ),
      actions: [
        _isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: MovieLoading(),
              )
            : IconButton(
                icon: _isFavorite
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: _toggleFavoriteStatus,
              ),
      ],
    );
  }

  Future<void> _toggleFavoriteStatus() async {
    final movieApiService = sl<MovieApiServiceImpl>();
    if (_isFavorite) {
      await movieApiService.quitFavoriteMovie(widget.movieEntity.id);
    } else {
      await movieApiService.addFavoriteMovie(widget.movieEntity.id);
    }
    await _checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
      stream: CheckInternetConnection().internetStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MovieError(message: 'Error getting movies');
        }
        if (!snapshot.hasData) return const MovieLoading();
        if (snapshot.data == ConnectionStatus.offline) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.movieEntity.title}'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go('/home');
                },
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MovieDetails(widget: widget),
            ),
          );
        } else {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MovieDetails(widget: widget),
            ),
          );
        }
      },
    );
  }
}
