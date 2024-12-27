import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/datasources/movie_datasource_impl.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/repositories/movie_repository_impl.dart';

/// ### Movie Repository Provider
/// Is a provider that exposes a [MoviesRepository] instance. This provider is used to inject the repository in the use cases.
/// 
/// ### Author:
/// Gonzalo Quedena
final movieRepositoryProvider = Provider<MoviesRepository>(
  (ref) {
    return MovieRepositoryImpl(MovieDatasourceImpl());
  },
);
