import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/datasources/local_storage_datasource_impl.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/repositories/local_storage_repository_impl.dart';

/// ### Local Storage Repository Provider
/// Is a provider that exposes a [LocalStorageRepository] instance. This provider is used to inject the repository in the use cases.
final localStorageRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  return LocalStorageRepositoryImpl(LocalStorageDatasourceImpl());
});