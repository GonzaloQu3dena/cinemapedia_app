import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/core/helpers/human_formats.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

/// ### Search Movie Delegate
/// It's a delegate to search movies.
/// 
/// #### Properties:
/// - [searchMovieCallback]: Callback to search movies.
/// - [initialMovies]: Initial list of movies.
/// - [debouncedMovies]: Stream controller to debounce the search.
/// - [isLoadingStream]: Stream controller to show the loading state.
/// - [_debounceTimer]: Timer to debounce the search.
/// - [_isClosed]: Flag to know if the streams are closed.
/// 
/// #### Methods:
/// - [clearStreams]: Clear the streams.
/// - [_onQueryChanged]: Callback to search movies.
/// - [_buildResultsAndSuggestions]: Build the results and suggestions.
/// - [buildActions]: Build the actions.
/// - [buildLeading]: Build the leading.
/// - [buildResults]: Build the results.
/// - [buildSuggestions]: Build the suggestions.
/// 
/// #### Author:
/// Gonzalo Quedena
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovieCallback;
  List<Movie> initialMovies;

  final StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;
  bool _isClosed = false;

  SearchMovieDelegate({
    required this.searchMovieCallback,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Search movie');

  void clearStreams() {
    if (!_isClosed) {
      debouncedMovies.close();
      isLoadingStream.close();
      _isClosed = true;
    }
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (_isClosed) return;
      final movies = await searchMovieCallback(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  Widget _buildResultsAndSuggestions(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 1),
              spins: 10,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions(context);
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie) onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(
                    child: child,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    movie.overview.length > 100
                        ? '${movie.overview.substring(0, 100)}...'
                        : movie.overview,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}