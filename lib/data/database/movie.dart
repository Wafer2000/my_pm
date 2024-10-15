import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:my_pm/data/models/movie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  static final MovieDatabase _instance = MovieDatabase._internal();
  static Database? _database;

  MovieDatabase._internal();

  factory MovieDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final movieDirectory = Directory('${directory.path}/movies');

      if (!await movieDirectory.exists()) {
        await movieDirectory.create(recursive: true);
      }

      final path = '${movieDirectory.path}/movies.db';

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE movies (
              id INTEGER PRIMARY KEY,
              title TEXT,
              overview TEXT,
              releaseDate TEXT,
              voteAverage REAL,
              backdropPath TEXT,
              posterPath TEXT,
              popularity REAL
            )
          ''');

          await db.execute('''
            CREATE TABLE favorite_movies (
              id INTEGER PRIMARY KEY,
              title TEXT,
              overview TEXT,
              releaseDate TEXT,
              voteAverage REAL,
              backdropPath TEXT,
              posterPath TEXT,
              popularity REAL
            )
          ''');
        },
      );
    } catch (e) {
      Left('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> insertMovie(MovieModel movie) async {
    try {
      final db = await database;
      await db.insert(
        'movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      Left('Error inserting movie: $e');
    }
  }

  Future<List<MovieModel>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    try {
      return List.generate(maps.length, (i) {
        final map = maps[i];
        return MovieModel(
          backdropPath: (map['backdropPath'] as String?) ?? '',
          posterPath: (map['posterPath'] as String?) ?? '',
          id: map['id'] ?? 0,
          title: (map['title'] as String?) ?? '',
          overview: (map['overview'] as String?) ?? '',
          popularity: (map['popularity'] as num?)?.toDouble() ?? 0.0,
          releaseDate: (map['releaseDate'] as String?) ?? '',
          voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0.0,
        );
      });
    } catch (e) {
      print('Error converting favorite movies: $e');
      return [];
    }
  }

  Future<void> insertFavoriteMovie(MovieModel movie) async {
    try {
      final db = await database;
      await db.insert(
        'favorite_movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      Left('Error inserting favorite movie: $e');
    }
  }

  Future<List<MovieModel>> getFavoriteMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_movies');
    return List<MovieModel>.generate(maps.length, (i) {
      final map = maps[i];
      return MovieModel(
        backdropPath: (map['backdropPath'] as String?) ?? '',
        posterPath: (map['posterPath'] as String?) ?? '',
        id: (map['id'] as int),
        title: (map['title'] as String?) ?? '',
        overview: (map['overview'] as String?) ?? '',
        popularity: (map['popularity'] as num?)?.toDouble() ?? 0.0,
        releaseDate: (map['releaseDate'] as String?) ?? '',
        voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0.0,
      );
    });
  }

  Future<Either<String, List<MovieModel>>> getLocalFavoriteMovies() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('favorite_movies');
      final movies = List<MovieModel>.generate(maps.length, (i) {
        final map = maps[i];
        return MovieModel.fromMap(map);
      });
      return Right(movies);
    } catch (e) {
      return Left('Error al obtener las películas favoritas: ${e.toString()}');
    }
  }

  Future<void> clearFavoriteMovies() async {
    try {
      final db = await database;
      await db.delete('favorite_movies');
    } catch (e) {
      Left('Error clearing favorite movies: $e');
    }
  }
}
