import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/actors_repository.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/datasources/actors_datasource_impl.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/repositories/actors_repository_impl.dart';

/// ### Actors Repository Provider
/// Is a provider that exposes a [ActorsRepository] instance. This provider is used to inject the repository in the use cases.
/// 
/// #### Author:
/// Gonzalo Quedena
final actorsRepositoryProvider = Provider<ActorsRepository>(
  (ref) {
    return ActorsRepositoryImpl(ActorsDatasourceImpl());
  },
);
